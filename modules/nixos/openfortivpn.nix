{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    openfortivpn
  ];
}