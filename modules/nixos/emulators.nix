{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    melonDS #DS emulator
  ];
}
