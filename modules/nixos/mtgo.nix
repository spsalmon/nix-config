# modules/mtgo.nix
{ pkgs, ... }:

let
  mtgo = pkgs.writeShellApplication {
    name = "mtgo";
    runtimeInputs = with pkgs; [
      wineWowPackages.stagingFull
      winetricks
      cabextract
      curl
      util-linux
      coreutils
    ];
    text = ''
      : "''${WINEPREFIX:=$HOME/.local/share/mtgo}"
      export WINEPREFIX
      export WINEARCH=win64
      export WINEDEBUG="''${WINEDEBUG:--all}"
      export WINEFSYNC=1

      bootstrap() {
        echo "[mtgo] First-run bootstrap at $WINEPREFIX (~10 min, mostly dotnet48)..."
        mkdir -p "$WINEPREFIX"

        wineboot --init
        wineserver --wait
        # Force user-profile setup so %AppData% is resolvable before winetricks runs
        wine cmd.exe /c "echo boot" 2>/dev/null || true
        wineserver --wait

        winetricks -q corefonts calibri tahoma
        WINEDLLOVERRIDES="mscoree=" taskset -c 0 winetricks -q -f dotnet48
        winetricks -q win10 sound=alsa renderer=gdi

        echo "[mtgo] Fetching MTGO ClickOnce installer..."
        curl -fL -o "$WINEPREFIX/mtgo-setup.exe" \
          "https://mtgo.patch.daybreakgames.com/patch/mtg/live/client/setup.exe?v=8"

        touch "$WINEPREFIX/.bootstrapped"
        echo "[mtgo] Bootstrap done."
      }

      [ -f "$WINEPREFIX/.bootstrapped" ] || bootstrap

      exec wine "$WINEPREFIX/mtgo-setup.exe"
    '';
  };

  mtgoDesktop = pkgs.makeDesktopItem {
    name = "mtgo";
    desktopName = "Magic: The Gathering Online";
    exec = "${mtgo}/bin/mtgo";
    icon = "wine";
    categories = [ "Game" "CardGame" ];
    comment = "MTGO via Wine";
  };
in {
  environment.systemPackages = [ mtgo mtgoDesktop ];
}
