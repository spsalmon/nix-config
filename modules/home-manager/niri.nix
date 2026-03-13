{pkgs, config, lib, inputs, ... }:
{
  programs.niri.settings.gestures.hot-corners.enable = false
  programs.niri.settings.binds = {
    "Mod+D".action.spawn = "fuzzel";
    "Mod+T".action.spawn = "kitty";
    "Mod+1".action.focus-workspace = 1;
  };
}
