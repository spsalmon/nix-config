{ config, pkgs, inputs, ... }:

{
    
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/python.nix
      ../../modules/nixos/tmux.nix
    ];

}