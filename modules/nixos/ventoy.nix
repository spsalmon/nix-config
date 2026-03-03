{ lib, config, pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.10"
    "ventoy-qt5-1.1.07"
  ];
  environment.systemPackages = with pkgs; [
    ventoy-full-qt
  ];
}
