{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    melonds #DS emulator
  ];
}
