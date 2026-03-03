{ lib, config, pkgs, ... }:
{
  imports =
    [
      ./thunar.nix
    ];
  services.xserver.enable = true;

  # No GNOME/GDM
  services.xserver.displayManager.gdm.enable = false;

  # LightDM login (X11)
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;

  # Openbox session available to the DM
  services.xserver.windowManager.openbox.enable = true;

  # Optional compositor
  services.picom.enable = true;

  environment.systemPackages = with pkgs; [
    tint2
    rofi
    feh
    lxappearance
    xdg-utils   # xdg-open, etc (recommended)
  ];
}