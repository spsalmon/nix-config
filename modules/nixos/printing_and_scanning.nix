{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sane-airscan
    epsonscan2
    cups-filters
    epson-workforce-635-nx625-series
    
    epson-escpr
    xsane
  ];
}
