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
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      background_color = "0x24273a";
    };

    "$terminal" = "alacritty";

    "$mainMod" = "SUPER";

    bindm = [
      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

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

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, focusworkspaceoncurrentmonitor, 1"
      "$mainMod, 2, focusworkspaceoncurrentmonitor, 2"
      "$mainMod, 3, focusworkspaceoncurrentmonitor, 3"
      "$mainMod, 4, focusworkspaceoncurrentmonitor, 4"
      "$mainMod, 5, focusworkspaceoncurrentmonitor, 5"
      "$mainMod, 6, focusworkspaceoncurrentmonitor, 6"
      "$mainMod, 7, focusworkspaceoncurrentmonitor, 7"
      "$mainMod, 8, focusworkspaceoncurrentmonitor, 8"
      "$mainMod, 9, focusworkspaceoncurrentmonitor, 9"
      "$mainMod, 0, focusworkspaceoncurrentmonitor, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
    ];
  };
}