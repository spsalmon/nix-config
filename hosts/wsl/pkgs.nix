{ config, pkgs, inputs, username, ... }:

{
    
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/python.nix
    ];

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

}
