{pkgs, config, lib, inputs, ... }:
{
  programs.niri.settings.gestures.hot-corners.enable = false;
  programs.niri.settings.binds = {

    # launching and spawning
    "Mod+R".action.spawn = "fuzzel";
    "Mod+B".action.spawn = "firefox";
    "Mod+T".action.spawn = "kitty";

    # navigation
    "Mod+H".action.focus-column-left;
    "Mod+L".action.focus-column-right;
    "Mod+1".action.focus-workspace = 1;
  };
}
