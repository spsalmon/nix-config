{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];

}