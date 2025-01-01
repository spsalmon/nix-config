{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.staging
    winetricks
  ];
}
