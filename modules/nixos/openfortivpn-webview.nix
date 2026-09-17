{ lib, config, pkgs, ... }:

# SAML/SSO login for a FortiGate SSL-VPN.
#
# openfortivpn itself can only do username/password auth. With SAML the gateway
# hands you off to an identity provider (university SSO, MFA prompt, ...) in a
# browser and the only thing that comes back is a session cookie, SVPNCOOKIE.
# openfortivpn-webview <https://github.com/gm-vm/openfortivpn-webview> is an
# embedded Chromium that opens https://<gateway>/remote/saml/start, lets you log
# in normally, and prints `SVPNCOOKIE=<value>` on stdout the moment the gateway
# sets it. openfortivpn then takes that cookie instead of credentials.
#
# This module installs both halves and wires them together in a `fortivpn`
# command that does the whole dance in one go.

let
  cfg = config.local.openfortivpn-webview;

  # Both flavours install a binary called `openfortivpn-webview`, so exactly one
  # of them may be in systemPackages. Electron is upstream's recommended one;
  # the Qt build is much lighter (no bundled Chromium+Node) but its README warns
  # it "may have some issues with some SAML providers". Switch with
  # `local.openfortivpn-webview.variant = "qt";` if the Electron window misbehaves.
  webviewPkg =
    if cfg.variant == "electron" then
      pkgs.openfortivpn-webview
    else
      pkgs.openfortivpn-webview-qt;

  # Args for the webview, fixed at build time from the options below.
  webviewArgs =
    lib.optional (cfg.realm != null) "--realm=${cfg.realm}"
    ++ lib.optional (cfg.urlRegex != null) "--url-regex=${cfg.urlRegex}"
    ++ lib.optional (cfg.trustedCert != null) "--trusted-cert=${cfg.trustedCert}"
    ++ cfg.webviewExtraArgs;

  fortivpn = pkgs.writeShellApplication {
    name = "fortivpn";
    runtimeInputs = [ webviewPkg pkgs.gnugrep pkgs.coreutils ];
    text = ''
      usage() {
        cat <<'EOF'
      Usage: fortivpn [<host>[:<port>]] [extra openfortivpn args...]

      Opens the SAML login page for the gateway, then brings the tunnel up with
      the resulting session cookie. The gateway defaults to
      local.openfortivpn-webview.gateway; anything else is passed through to
      openfortivpn (e.g. --persistent=10, -v, --no-dns).
      EOF
      }

      if [ "''${1-}" = "-h" ] || [ "''${1-}" = "--help" ]; then
        usage
        exit 0
      fi

      gateway=${lib.escapeShellArg (toString cfg.gateway)}

      # A leading non-flag argument overrides the configured gateway.
      if [ "$#" -gt 0 ] && [ "''${1#-}" = "$1" ]; then
        gateway=$1
        shift
      fi

      if [ -z "$gateway" ]; then
        echo "fortivpn: no gateway given, and local.openfortivpn-webview.gateway is unset" >&2
        usage >&2
        exit 1
      fi

      webview_args=( ${lib.escapeShellArgs webviewArgs} )

      echo "fortivpn: opening SAML login for $gateway" >&2

      # The webview exits by itself once the gateway sets SVPNCOOKIE. Chromium is
      # noisy on stderr, which is left alone so certificate and SSO errors stay
      # visible; only stdout carries the cookie.
      if ! webview_out=$(openfortivpn-webview "''${webview_args[@]}" "$gateway"); then
        echo "fortivpn: openfortivpn-webview failed" >&2
        exit 1
      fi

      # A here-string, not a pipe: writeShellApplication turns on pipefail, and
      # `grep -m1` exits at the match while printf may still be writing the rest of
      # Chromium's chatter. printf would then die on SIGPIPE and fail the pipeline
      # even though the cookie was found.
      if ! cookie=$(grep -m1 '^SVPNCOOKIE=' <<<"$webview_out"); then
        echo "fortivpn: login window closed without producing an SVPNCOOKIE" >&2
        exit 1
      fi

      echo "fortivpn: cookie obtained, bringing the tunnel up (needs root)" >&2

      # The cookie is a complete VPN session credential, so it goes in over stdin
      # rather than as --cookie=... on the command line: /proc/<pid>/cmdline is
      # world-readable, stdin is not. openfortivpn strips the trailing newline
      # itself (auth_set_cookie stops at \r, \n or ;).
      printf '%s' "$cookie" | /run/wrappers/bin/sudo ${lib.getExe pkgs.openfortivpn} \
        "$gateway" --cookie-on-stdin ${lib.escapeShellArgs cfg.extraArgs} "$@"
    '';
  };
in
{
  options.local.openfortivpn-webview = {
    gateway = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "vpn.university.edu:443";
      description = ''
        Default FortiGate gateway, as host or host:port (port defaults to 443).
        Used by `fortivpn` when no gateway is given on the command line.
      '';
    };

    variant = lib.mkOption {
      type = lib.types.enum [ "electron" "qt" ];
      default = "electron";
      description = ''
        Which openfortivpn-webview build to install. Only one can be installed at
        a time as both provide the `openfortivpn-webview` binary.
      '';
    };

    realm = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Authentication realm, if the gateway needs one. Usually not.";
    };

    urlRegex = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/sslvpn/portal(/|\\.html)";
      description = ''
        The webview waits for a URL matching this regex before printing the
        cookie, which keeps a half-finished login from producing a stale cookie.
        Upstream's default matches the standard Fortinet portal; override it if
        the gateway lands somewhere else after SSO and `fortivpn` hangs with the
        window sitting on a logged-in page.
      '';
    };

    trustedCert = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "sha256/ExAmPlEBase64DigestOfTheCert=";
      description = ''
        Fingerprint of a certificate to trust even if it does not validate, for
        gateways with a self-signed or otherwise broken chain. The webview dumps
        the fingerprint of the offending cert to stderr, so run `fortivpn` once
        without this to find the value.
      '';
    };

    webviewExtraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "--proxy-server=proxy.example.com:8080" ];
      description = "Extra arguments passed to openfortivpn-webview.";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "--persistent=10" ];
      description = "Extra arguments always passed to openfortivpn.";
    };

    passwordlessSudo = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Let wheel run this exact openfortivpn binary as root without a password.

        Off by default, and worth thinking about before turning on: the rule
        cannot restrict *arguments*, and openfortivpn takes options such as
        --pppd-plugin and --pppd-call that make root run code of your choosing.
        So this effectively grants passwordless root to anyone in wheel, not just
        the ability to bring this VPN up. Convenient on a single-user laptop,
        wrong on a shared machine.
      '';
    };
  };

  config = {
    environment.systemPackages = [
      pkgs.openfortivpn
      webviewPkg
      fortivpn
    ];

    security.sudo.extraRules = lib.mkIf cfg.passwordlessSudo [{
      groups = [ "wheel" ];
      commands = [{
        command = "${lib.getExe pkgs.openfortivpn}";
        options = [ "NOPASSWD" ];
      }];
    }];
  };
}
