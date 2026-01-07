{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sane-airscan
    #epsonscan2
    cups-filters
    xsane
  ];

  services.printing = { enable = true; drivers = [ pkgs.epson-escpr pkgs.brlaser]; };
  services.avahi = { enable = true; nssmdns4 = true; };
}
