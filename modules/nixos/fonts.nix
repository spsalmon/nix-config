{ config, lib, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
      fira-code
      fira-code-symbols
      ibm-plex
    ];

    fontconfig = {
    defaultFonts = {
      serif = [ "IMB Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "IBM Plex Mono" ];
    };
  };
  
  };

}