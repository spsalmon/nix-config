{ lib, config, pkgs, ... }:
{
  # NOTE: insecure-package permits live at the host level (hosts/*/pkgs.nix)
  # because nixpkgs.config merges via recursiveUpdate, so a second definition
  # in a module would clobber the host list rather than append to it.
  environment.systemPackages = with pkgs; [
    ventoy-full-qt
  ];
}
