{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}
