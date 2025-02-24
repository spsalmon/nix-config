{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sane-airscan
    epsonscan2
    cups-filters
    epson-escpr
    xsane
  ];
}
