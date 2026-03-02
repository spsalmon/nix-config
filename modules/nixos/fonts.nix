{ config, lib, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      ibm-plex
      nerd-fonts.blex-mono
    ];

    fontconfig = {
    defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "IBM Plex Mono" ];
    };
  };
  
  };

}
