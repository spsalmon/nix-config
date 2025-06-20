{ lib, config, pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.05"
  ];
  environment.systemPackages = with pkgs; [
    ventoy-full-qt
  ];
}
