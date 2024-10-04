{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    reaper
    vital
    surge-XT
  ];
}
