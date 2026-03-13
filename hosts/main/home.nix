{ config, pkgs, inputs, username, ... }:

{
  imports =
    [
      ../default/home.nix
      #../../modules/home-manager/openbox.nix
      #../../modules/home-manager/noctalia_shell.nix
    ];
}
