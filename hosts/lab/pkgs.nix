{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/gnome.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}
