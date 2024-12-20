{ config, lib, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      #noto-fonts
      #noto-fonts-cjk
      #noto-fonts-emoji
      #twemoji-color-font
      #fira-code
      #fira-code-symbols
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
