{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/obs.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/podman.nix
      ../../modules/nixos/r2modman.nix
      ../../modules/nixos/chromium.nix
      ../../modules/nixos/python.nix
      ../../modules/nixos/osu.nix
      ../../modules/nixos/lutris_and_wine.nix
    ];

  environment.systemPackages = with pkgs; [
    godot_4
    krita
    audacity
    xclicker
  ];
}
