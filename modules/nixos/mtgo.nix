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
        winetricks -q vcrun2022 d3dcompiler_47
        # renderer=gl: wined3d OpenGL backend uses the GPU and supports WPF D3DImage
        # readback correctly (glReadPixels). DXVK's Vulkan backend breaks D3DImage
        # compositing, causing a black screen.
        winetricks -q win10 sound=disabled renderer=gl

        echo "[mtgo] Fetching MTGO ClickOnce installer..."
        curl -fL -o "$WINEPREFIX/mtgo-setup.exe" \
          "https://mtgo.patch.daybreakgames.com/patch/mtg/live/client/setup.exe?v=8"

        touch "$WINEPREFIX/.bootstrapped"
        echo "[mtgo] Bootstrap done."
      }

      [ -f "$WINEPREFIX/.bootstrapped" ] || bootstrap

      # Disable CSMT (command stream multi-threading): wined3d's background GL
      # submission thread races with WPF D3DImage LockRect, causing flickering and
      # random crashes. Without CSMT, GL calls are synchronous and LockRect is safe.
      wine reg add "HKCU\\Software\\Wine\\Direct3D" /v csmt /t REG_DWORD /d 0 /f 2>/dev/null
      wineserver --wait

      # Force wined3d OpenGL even if DXVK DLLs are present in the prefix
      export WINEDLLOVERRIDES="d3d9=b,dxgi=b"
      export __GL_SHADER_DISK_CACHE=1
      export __GL_SHADER_DISK_CACHE_PATH="$WINEPREFIX"
      # Sync GL to vblank: prevents tearing and frame-pacing flicker under XWayland/niri
      export __GL_SYNC_TO_VBLANK=1
      unset WAYLAND_DISPLAY

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
