{ lib, config, pkgs, username,... }:
{
  musnix.enable = true;
  users.users.${username}.extraGroups = [ "audio" ];
  
  environment.systemPackages = with pkgs; [
    reaper
    ardour

    # synths
    vital
    surge-XT

    # drums
    drumkv1
    hydrogen

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wineWowPackages.stable
  ];
}
