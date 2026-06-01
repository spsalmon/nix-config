{pkgs, config, lib, inputs, ... }:
{
  programs.niri.settings.spawn-at-startup = [
    { command = [ "noctalia-shell" ]; }
  ];
  programs.niri.settings.gestures.hot-corners.enable = false;

  programs.niri.settings.workspaces = {
    "1" = {};
    "2" = {};
    "3" = {};
    "4" = {};
    "5" = {};
    "6" = {};
    "7" = {};
    "8" = {};
    "9" = {};
  };

  programs.niri.settings.binds = {

    # launching and spawning
    "Mod+R".action.spawn = "fuzzel";
    "Mod+B".action.spawn = "firefox";
    "Mod+T".action.spawn = "kitty";

    # close window
    "Mod+Q".action.close-window = [];

    # focus navigation
    "Mod+H".action.focus-column-left = [];
    "Mod+L".action.focus-column-right = [];
    "Mod+J".action.focus-window-down = [];
    "Mod+K".action.focus-window-up = [];

    # focus workspace (by number)
    "Mod+1".action.focus-workspace = "1";
    "Mod+2".action.focus-workspace = "2";
    "Mod+3".action.focus-workspace = "3";
    "Mod+4".action.focus-workspace = "4";
    "Mod+5".action.focus-workspace = "5";
    "Mod+6".action.focus-workspace = "6";
    "Mod+7".action.focus-workspace = "7";
    "Mod+8".action.focus-workspace = "8";
    "Mod+9".action.focus-workspace = "9";

    # focus workspace (relative)
    "Mod+Ctrl+J".action.focus-workspace-down = [];
    "Mod+Ctrl+K".action.focus-workspace-up = [];

    # focus monitor
    "Mod+Ctrl+H".action.focus-monitor-left = [];
    "Mod+Ctrl+L".action.focus-monitor-right = [];

    # move windows/columns within workspace
    "Mod+Shift+H".action.move-column-left = [];
    "Mod+Shift+L".action.move-column-right = [];
    "Mod+Shift+J".action.move-window-down = [];
    "Mod+Shift+K".action.move-window-up = [];

    # move window to workspace (by number)
    "Mod+Shift+1".action.move-window-to-workspace = "1";
    "Mod+Shift+2".action.move-window-to-workspace = "2";
    "Mod+Shift+3".action.move-window-to-workspace = "3";
    "Mod+Shift+4".action.move-window-to-workspace = "4";
    "Mod+Shift+5".action.move-window-to-workspace = "5";
    "Mod+Shift+6".action.move-window-to-workspace = "6";
    "Mod+Shift+7".action.move-window-to-workspace = "7";
    "Mod+Shift+8".action.move-window-to-workspace = "8";
    "Mod+Shift+9".action.move-window-to-workspace = "9";

    # move window to workspace (relative)
    "Mod+Shift+Ctrl+J".action.move-window-to-workspace-down = [];
    "Mod+Shift+Ctrl+K".action.move-window-to-workspace-up = [];

    # move column to monitor
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

    # scroll wheel: window navigation
    "Mod+WheelScrollDown".action.focus-column-right = [];
    "Mod+WheelScrollUp".action.focus-column-left    = [];

    # scroll wheel: move window within workspace
    "Mod+Shift+WheelScrollDown".action.move-column-right = [];
    "Mod+Shift+WheelScrollUp".action.move-column-left    = [];

    # scroll wheel: workspace navigation
    "Mod+Ctrl+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = []; };
    "Mod+Ctrl+WheelScrollUp"   = { cooldown-ms = 150; action.focus-workspace-up   = []; };

    # scroll wheel: move window to workspace
    "Mod+Shift+Ctrl+WheelScrollDown" = { cooldown-ms = 150; action.move-window-to-workspace-down = []; };
    "Mod+Shift+Ctrl+WheelScrollUp"   = { cooldown-ms = 150; action.move-window-to-workspace-up   = []; };

    # window state
    "Mod+F".action.fullscreen-window = [];
    "Mod+M".action.maximize-column = [];
    "Mod+V".action.toggle-window-floating = [];
  };
}
