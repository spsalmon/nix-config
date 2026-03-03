{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    discord
  ];

}