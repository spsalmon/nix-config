{ config, pkgs, inputs, ... }:

{
    
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/python.nix
      ../../modules/nixos/tmux.nix
    ];

  programs.fish.shellAliases = {
    temacs = "tmux new -s 'emacs' -d emacs";
  };
  
}