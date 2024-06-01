{ lib, config, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pkgs.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.networkmanager.ethernet.macAddress = "preserve";
}
