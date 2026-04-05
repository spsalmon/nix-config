{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      # system
      ../default/pkgs.nix
      ../../modules/nixos/niri.nix
      ../../modules/nixos/display_manager.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix

      # programming
      ../../modules/nixos/godot.nix
      ../../modules/nixos/vscode.nix

      # gaming
      ../../modules/nixos/controllers.nix
      ../../modules/nixos/mtg.nix

      # software
      ../../modules/nixos/qbittorrent.nix
      ../../modules/nixos/podman.nix


    ];

  hardware.nvidia = {
    open = false;
  };
}
