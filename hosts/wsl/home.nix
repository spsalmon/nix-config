{ config, pkgs, inputs, username, ... }:

{
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
