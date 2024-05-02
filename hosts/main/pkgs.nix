{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/gnome.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
    ];

  environment.systemPackages = with pkgs; [
    godot_4
  ];
}
