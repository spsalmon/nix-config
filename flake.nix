{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    musnix.url = "github:musnix/musnix";
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs =
    { self, nixpkgs, home-manager, nixos-wsl, musnix, lanzaboote, niri, claude-code, ... }@inputs:
    let
      username = "sacha";
      system = "x86_64-linux";

      # Applied to every host
      commonModule = { pkgs, ... }: {
        users.users.${username}.isNormalUser = true;
        nixpkgs.overlays = [ claude-code.overlays.default ];
        environment.systemPackages = [ pkgs.claude-code ];
      };

      # Home-manager wiring for a given host directory
      hmModule = hostDir: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          sharedModules = [ ];
          users.${username} = import (hostDir + "/home.nix");
        };
      };

      # Secure Boot via lanzaboote (main only)
      lanzabooteModule = { pkgs, lib, ... }: {
        environment.systemPackages = [ pkgs.sbctl ];
        boot.loader.systemd-boot.enable = lib.mkForce false;
        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };

      mkHost = { hostName, extraModules ? [ ] }:
        let hostDir = ./hosts + "/${hostName}";
        in nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs username; };
          modules = [
            commonModule
            (hostDir + "/configuration.nix")
            home-manager.nixosModules.home-manager
            (hmModule hostDir)
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        default = mkHost { hostName = "default"; };

        lab = mkHost { hostName = "lab"; };

        gaming-laptop = mkHost {
          hostName = "gaming-laptop";
          extraModules = [ niri.nixosModules.niri ];
        };

        main = mkHost {
          hostName = "main";
          extraModules = [
            musnix.nixosModules.musnix
            lanzaboote.nixosModules.lanzaboote
            niri.nixosModules.niri
            lanzabooteModule
          ];
        };
      };
    };
}