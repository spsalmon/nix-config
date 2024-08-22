{ config, pkgs, inputs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  # git setup
  programs.git = {
    enable = true;
    userName = "spsalmon";
    userEmail = "psalmonsacha@gmail.com";
  };
}
