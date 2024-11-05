{ lib, config, pkgs, username,... }:
{
  musnix.enable = true;
  users.users.${username}.extraGroups = [ "audio" ];
  
  environment.systemPackages = with pkgs; [
    reaper
    ardour

    # Support for Windows VST2/VST3 plugins
    yabridge
    yabridgectl
    wineWowPackages.stable

    # synths
    surge-XT
    vital

    # drums
    hydrogen
    drumgizmo
    drumkv1
  ];
}
