{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    reaper

    # synths
    vital
    surge-XT

    # drums
    drumkv1
    hydrogen
  ];
}
