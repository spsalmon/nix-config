{ lib, config, pkgs, ... }:
{
  # Enable the KDE Plasma 6 Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Disable all the crappy apps that come with it
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];
}