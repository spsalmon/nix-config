{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sane-airscan
    epsonscan2
    epson-escpr
    xsane
  ];
}
