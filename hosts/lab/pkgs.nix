{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/macchanger.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/podman.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}
