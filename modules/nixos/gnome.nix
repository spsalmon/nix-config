{ lib, config, pkgs, ... }:
{
  # Activate GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Disable autosuspend during login
  services.displayManager.gdm.autoSuspend = false;

  # Disable wayland
  services.displayManager.gdm.wayland = false;

  # Adding some packages to make life easier
  environment.systemPackages = with pkgs; [
    dconf2nix
    gnome-tweaks
    gparted
  ];

  # Activate dconf
  programs.dconf.enable = true;
  
  # Remove the bloat
  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-backgrounds
    baobab
    epiphany
    gnome-text-editor
    gnome-calendar
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-weather
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];
}
