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
      sensitivity = "-0.4";
      accel_profile = "flat";
      natural_scroll = "false";
    };

    input.touchpad = {
      natural_scroll = "true";
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
      "$mainMod, V, exec, codium"
      ", PrintScreen, exec, shotman"

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
      "$mainMod SHIFT, Up, movetoworkspace, m+1"
      "$mainMod SHIFT, Down, movetoworkspace, m-1"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, code:10, workspace, 1"
      "$mainMod, code:11, workspace, 2"
      "$mainMod, code:12, workspace, 3"
      "$mainMod, code:13, workspace, 4"
      "$mainMod, code:14, workspace, 5"
      "$mainMod, code:15, workspace, 6"
      "$mainMod, code:16, workspace, 7"
      "$mainMod, code:17, workspace, 8"
      "$mainMod, code:18, workspace, 9"
      "$mainMod, code:19, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, code:10, movetoworkspace, 1"
      "$mainMod SHIFT, code:11, movetoworkspace, 2"
      "$mainMod SHIFT, code:12, movetoworkspace, 3"
      "$mainMod SHIFT, code:13, movetoworkspace, 4"
      "$mainMod SHIFT, code:14, movetoworkspace, 5"
      "$mainMod SHIFT, code:15, movetoworkspace, 6"
      "$mainMod SHIFT, code:16, movetoworkspace, 7"
      "$mainMod SHIFT, code:17, movetoworkspace, 8"
      "$mainMod SHIFT, code:18, movetoworkspace, 9"
      "$mainMod SHIFT, code:19, movetoworkspace, 10"
    ];
  };
}