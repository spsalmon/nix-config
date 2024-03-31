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

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, &"
      "$mainMod, 2, workspace, é"
      "$mainMod, 3, workspace, ''\""
      "$mainMod, 4, workspace, ''\'"
      "$mainMod, 5, workspace, ("
      "$mainMod, 6, workspace, -"
      "$mainMod, 7, workspace, è"
      "$mainMod, 8, workspace, _"
      "$mainMod, 9, workspace, ç"
      "$mainMod, 0, workspace, à"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, &"
      "$mainMod SHIFT, 2, movetoworkspace, é"
      "$mainMod SHIFT, 3, movetoworkspace, ''\""
      "$mainMod SHIFT, 4, movetoworkspace, ''\'"
      "$mainMod SHIFT, 5, movetoworkspace, ("
      "$mainMod SHIFT, 6, movetoworkspace, -"
      "$mainMod SHIFT, 7, movetoworkspace, è"
      "$mainMod SHIFT, 8, movetoworkspace, _"
      "$mainMod SHIFT, 9, movetoworkspace, ç"
      "$mainMod SHIFT, 0, movetoworkspace, à"
    ];
  };
}