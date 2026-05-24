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

        # wine-staging 10.x with new WoW64 doesn't populate %AppData% in the Windows
        # process environment.  Wine inherits Unix env vars, so exporting APPDATA here
        # causes cmd.exe (and winetricks) to see it as %AppData%.
        USERNAME=$(id -un)
        mkdir -p "$WINEPREFIX/drive_c/users/$USERNAME/AppData/Roaming"
        export APPDATA="C:\\users\\$USERNAME\\AppData\\Roaming"
        export USERPROFILE="C:\\users\\$USERNAME"

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
