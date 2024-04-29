{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;

  # Change MAC adress to access ethernet in the lab
  #networking.interfaces.enp0s13f0u3u4c2.macAddress = "a0:29:19:a0:d8:68";
  #networking.interfaces.wlp0s20f3.macAddress = "a0:29:19:a0:d8:68";
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  networking.networkmanager.ethernet.macAddress = "a0:29:19:a0:d8:68";
}
