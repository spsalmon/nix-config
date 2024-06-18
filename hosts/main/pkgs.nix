{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      #../../modules/nixos/gnome.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/obs.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/podman.nix
    ];

  environment.systemPackages = with pkgs; [
    godot_4
    krita
  ];
}
