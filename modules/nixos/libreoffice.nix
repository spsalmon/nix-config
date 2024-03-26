{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.en
    hunspellDicts.fr
  ];

}