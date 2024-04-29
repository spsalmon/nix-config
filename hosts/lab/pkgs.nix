{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;

  # Change MAC adress to access ethernet in the lab
  networking.networkmanager.ethernet.macAddress = "a0:29:19:a0:d8:68";
}
