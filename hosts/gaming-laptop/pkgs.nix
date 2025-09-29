{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/joycon.nix
      ../../modules/nixos/emulators.nix
      ../../modules/nixos/controllers.nix
      ../../modules/nixos/qbittorrent.nix
      ../../modules/nixos/virtualbox.nix
      ../../modules/nixos/mtg.nix
      ../../modules/nixos/godot.nix
    ];

  hardware.nvidia = {
    open = false;
  };
}
