{ lib, config, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/main-user.nix
      ./pkgs.nix
      inputs.home-manager.nixosModules.default
    ];
}
