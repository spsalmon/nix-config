{ lib, config, pkgs, ... }:
{
  # Activate GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Disable autosuspend during login
  services.xserver.displayManager.gdm.autoSuspend = false;

  # Adding dconf2nix to convert stuff easily
  environment.systemPackages = with pkgs; [
    dconf2nix
  ];

  # Activate dconf
  programs.dconf.enable = true;

  # Change mouse sensitivity in gdm login screen
  systemd.services.gdmsensitivity = {
    enable = true;
    description = "change the mouse sensitivity on the GDM login screen";
    unitConfig = {
      type = "simple";
    };
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/gsettings set org.gnome.desktop.peripherals.mouse speed '-0.55'";
      User = "gdm";
    };
    wantedBy = [ "multi-user.target" ];
  };
  
  # Remove the bloat
  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    # file-roller
    geary
    gnome-disk-utility
    # seahorse
    # sushi
    # sysprof
    #
    # gnome-shell-extensions
    #
    # adwaita-icon-theme
    # nixos-background-info
    gnome-backgrounds
    # gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    #
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    # gnome-clocks
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    # gnome-system-monitor
    gnome-weather
    # loupe
    # nautilus
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];
}
