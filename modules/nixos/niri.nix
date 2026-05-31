{ lib, config, pkgs, ... }:
{
  # Enable Niri
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite #xwayland support
    jq
    fuzzel
    kdePackages.dolphin
  ];
}