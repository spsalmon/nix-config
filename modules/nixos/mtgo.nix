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

        # NixOS wraps wine binaries in shell scripts, so winetricks can't read the
        # ELF machine-type byte and falls back to constructing a "wine64" path that
        # doesn't exist.  It then uses that missing binary as WINE_ARCH, causing every
        # cmd.exe call to silently produce no output (empty %AppData%).
        # Presetting WINE64 makes winetricks skip the broken fallback and use wine directly.
        export WINE64
        WINE64="$(which wine)"
        USERNAME=$(id -un)
        mkdir -p "$WINEPREFIX/drive_c/users/$USERNAME/AppData/Roaming"

        winetricks -q corefonts calibri tahoma
        WINEDLLOVERRIDES="mscoree=" taskset -c 0 winetricks -q -f dotnet48
        winetricks -q vcrun2022 d3dcompiler_47 dxvk
        winetricks -q win10 sound=disabled

        echo "[mtgo] Fetching MTGO ClickOnce installer..."
        curl -fL -o "$WINEPREFIX/mtgo-setup.exe" \
          "https://mtgo.patch.daybreakgames.com/patch/mtg/live/client/setup.exe?v=8"

        touch "$WINEPREFIX/.bootstrapped"
        touch "$WINEPREFIX/.dxvk_installed"
        echo "[mtgo] Bootstrap done."
      }

      install_dxvk() {
        echo "[mtgo] Installing DXVK for GPU acceleration..."
        export WINE64
        WINE64="$(which wine)"
        winetricks -q dxvk
        touch "$WINEPREFIX/.dxvk_installed"
      }

      [ -f "$WINEPREFIX/.bootstrapped" ] || bootstrap
      [ -f "$WINEPREFIX/.dxvk_installed" ] || install_dxvk

      export DXVK_ASYNC=1
      export __GL_SHADER_DISK_CACHE=1
      export __GL_SHADER_DISK_CACHE_PATH="$WINEPREFIX"

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
