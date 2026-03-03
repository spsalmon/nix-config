{ lib, config, pkgs, username, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      autoNumlock = true;
      wayland = {
        enable = true;
        compositor = "niri";
      };
    };
    defaultSession = null;
    autoLogin = {
      enable = false;
      user = username;
    };
  };
}