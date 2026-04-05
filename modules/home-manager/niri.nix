{pkgs, config, lib, inputs, ... }:
{
  programs.niri.settings.gestures.hot-corners.enable = false;
  programs.niri.settings.binds = {
    "Mod+R".action.spawn = "fuzzel";
    "Mod+B".action.spawn = "firefox";
    "Mod+T".action.spawn = "kitty";
    "Mod+1".action.focus-workspace = 1;
  };
}
