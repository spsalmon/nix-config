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

    "$terminal" = "alacritty";

    "$mod" = "SUPER";

    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
    bind=[
      # launch alacritty
      "$mod, A, exec, alacritty"
      "$mod, F, exec, firefox"
      "$mod, T, exec, tofi"
    ];
  };
}