{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/home.nix
    ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
}
