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
      ../../modules/nixos/mtgo.nix

      # software
      ../../modules/nixos/qbittorrent.nix
      ../../modules/nixos/docker.nix


    ];

  # docker 28.5.2 is flagged insecure in nixpkgs 25.11; accept it until a patched release lands
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
  ];

  # The GTX 1070 is Pascal, which NVIDIA dropped after the 580 branch.
  # nvidiaPackages.stable is now 595.x, so pin the legacy branch here.
  # Pascal also predates the open kernel modules (Turing+ only).
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
}
