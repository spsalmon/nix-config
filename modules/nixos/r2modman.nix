{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    r2modman
  ];
}