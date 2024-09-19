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
      ../../modules/nixos/osu_lazer.nix
      ../../modules/nixos/lutris_and_wine.nix
      
    ];

  environment.systemPackages = with pkgs; [
    godot_4
    krita
    audacity
    xclicker
  ];

  # enable the open source kernel drivers as they are supported on my 4060
  hardware.nvidia = {
    open = true;
  }
}
