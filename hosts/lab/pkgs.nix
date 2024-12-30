{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/macchanger.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/docker.nix
      ../../modules/lutris_and_wine.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}
