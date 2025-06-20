{ lib, config, pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];
  environment.systemPackages = with pkgs; [
    ventoy
  ];
}
