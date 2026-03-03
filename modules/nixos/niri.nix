{ lib, config, pkgs, ... }:
{
  # Enable Niri
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite #xwayland support
    jq
  ];
}