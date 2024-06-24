{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/macchanger.nix
      ../../modules/nixos/openfortivpn.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}