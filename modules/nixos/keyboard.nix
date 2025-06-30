{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qmk
    vial
  ];
}
