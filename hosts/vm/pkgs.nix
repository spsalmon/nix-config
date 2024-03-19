{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
}
