{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ../default/home.nix
      #../../modules/home-manager/kde.nix
      ../../modules/home-manager/gnome.nix
    ];
}
