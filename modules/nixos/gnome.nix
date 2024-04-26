{ lib, config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  # Disable all the crappy GNOME apps
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  ]) ++ (with pkgs.gnome; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game

    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  ]);
}