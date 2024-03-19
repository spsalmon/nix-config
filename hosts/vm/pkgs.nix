{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages;
}
