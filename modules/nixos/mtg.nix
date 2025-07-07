{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    seventeenlands
  ];
}
