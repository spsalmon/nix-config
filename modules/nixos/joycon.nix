{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    joycond
  ];
}