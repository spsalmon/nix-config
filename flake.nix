{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    musnix  = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, musnix, lanzaboote, ... }@inputs:
    let
      username = "sacha";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/default/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/default/home.nix;
          }
        ];
      };
      
      nixosConfigurations.gaming-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/gaming-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/gaming-laptop/home.nix;
          }
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username;};
        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "23.11";
            wsl.enable = true;
          }
          {users.users."${username}".isNormalUser = true;}
          ./hosts/wsl/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/wsl/home.nix;
          }
        ];
      };

      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/main/configuration.nix
          inputs.musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/main/home.nix;
          }
          
          ({ pkgs, lib, ... }: {

            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot.
              pkgs.sbctl
            ];

            # Lanzaboote currently replaces the systemd-boot module.
            # This setting is usually set to true in configuration.nix
            # generated at installation time. So we force it to false
            # for now.
            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          })
        ];
      };

      nixosConfigurations.lab = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs username;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/lab/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/lab/home.nix;
          }
        ];
      };

    };
}
