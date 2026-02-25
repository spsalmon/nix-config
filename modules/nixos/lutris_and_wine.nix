{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages
    winetricks
  ];
}
