{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # umu= {
    #   url = "git+https://github.com/Open-Wine-Components/umus-launcher/?dir=packaging\/nix&submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    musnix  = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, nixos-wsl, musnix,... }@inputs:
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
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

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
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

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
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/main/home.nix;
          }
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
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/lab/home.nix;
          }
        ];
      };

    };
}
