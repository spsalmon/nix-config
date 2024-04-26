{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam
  ];

  # Install steam and enable it 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.steam.gamescopeSession.enable = true;
}