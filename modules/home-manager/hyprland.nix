{pkgs, config, lib, inputs, ... }:
{
  home.packages = with pkgs; [ mako libnotify hyprpaper grim slurp pamixer ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };

    wayland.windowManager.hyprland.settings = {
    decoration = {
      shadow_offset = "0 5";
      "col.shadow" = "rgba(00000099)";
    };

    general = {
      gaps_in = "5";
      gaps_out = "5";
    };

    animations = {
      enabled = false;
    };
    
    input = {
      kb_layout = "fr";
      kb_options="grp:caps_toggle";
      sensitivity = "-0.5";
      accel_profile = "flat";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      background_color = "0x24273a";
    };

    "$terminal" = "alacritty";

    "$mainMod" = "SUPER";

    monitor = ",preferred,auto,1";

    exec-once = [
      "waybar"
      "mako"
      "hyprpaper"
    ];
    
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bind=[
      # apps
      "$mainMod, T, exec, $terminal"
      "$mainMod, F, exec, firefox"
      "$mainMod, A, exec, fuzzel"

      # App management
      "$mainMod SHIFT, Q, killactive"
      "$mainMod SHIFT, F, togglefloating"
      "$mainMod SHIFT, M, exit"

      # move focus with mainMod + hjkl
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      "$mainMod, Tab, cyclenext"
      "$mainMod, Tab, alterzorder"

      # nagivate through workspaces with arrow keys
      "$mainMod, Up, focusworkspaceoncurrentmonitor, e+1"
      "$mainMod, Down, focusworkspaceoncurrentmonitor, e-1"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, &, workspace, 1"
      "$mainMod, é, workspace, 2"
      "$mainMod, ''\", workspace, 3"
      "$mainMod, ''', workspace, 4"
      "$mainMod, (, workspace, 5"
      "$mainMod, -, workspace, 6"
      "$mainMod, è, workspace, 7"
      "$mainMod, _, workspace, 8"
      "$mainMod, ç, workspace, 9"
      "$mainMod, à, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, &, movetoworkspace, 1"
      "$mainMod SHIFT, é, movetoworkspace, 2"
      "$mainMod SHIFT, ''\", movetoworkspace, 3"
      "$mainMod SHIFT, ''', movetoworkspace, 4"
      "$mainMod SHIFT, (, movetoworkspace, 5"
      "$mainMod SHIFT, -, movetoworkspace, 6"
      "$mainMod SHIFT, è, movetoworkspace, 7"
      "$mainMod SHIFT, _, movetoworkspace, 8"
      "$mainMod SHIFT, ç, movetoworkspace, 9"
      "$mainMod SHIFT, à, movetoworkspace, 10"
    ];
  };
}