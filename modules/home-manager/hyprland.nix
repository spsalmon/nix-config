{pkgs, config, lib, inputs, ... }:
{
  # Enable Hyprland
  services.xserver.displayManager.gdm.wayland = true;  

  programs.hyprland = {    
      enable = true;    
      xwayland.enable = true;
      systemd.enable = true;
  };

  wayland.windowManager.hyprland.enable = true;

    wayland.windowManager.hyprland.settings = {
    decoration = {
      shadow_offset = "0 5";
      "col.shadow" = "rgba(00000099)";
    };

    "$terminal" = "alacritty";

    "$mod" = "SUPER";

    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
      # launch alacritty
      "SUPER, Q, alacritty"
      "SUPER, F, firefox"
    ];
  };
}