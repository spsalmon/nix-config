{ config, pkgs, inputs, username,... }:

{
  imports =
    [
      # system
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/display_manager.nix
      ../../modules/nixos/niri.nix
      ../../modules/nixos/secure_boot.nix
      ../../modules/nixos/keyboard.nix
      ../../modules/nixos/printing_and_scanning.nix

      # programming
      ../../modules/nixos/python.nix
      ../../modules/nixos/godot.nix

      # software
      ../../modules/nixos/obs.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/podman.nix
      ../../modules/nixos/r2modman.nix
      ../../modules/nixos/chromium.nix
      ../../modules/nixos/music.nix
      ../../modules/nixos/gimp.nix
      ../../modules/nixos/docker.nix
      ../../modules/nixos/ventoy.nix
      ../../modules/nixos/zoom.nix
      ../../modules/nixos/qbittorrent.nix

      # gaming
      ../../modules/nixos/cockatrice.nix
      ../../modules/nixos/mtg.nix
      ../../modules/nixos/emulators.nix
      ../../modules/nixos/osu_lazer.nix
      ../../modules/nixos/lutris_and_wine.nix
    ];
  
  # enable the open source kernel drivers as they are supported on my 4060
  # according to some people, this could cause problems with cuda, so I'm disabling it
  hardware.nvidia = {
    open = false;
  };
}
