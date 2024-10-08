{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    reaper
    ardour

    # synths
    vital
    surge-XT

    # drums
    drumkv1
    hydrogen
  ];
}
