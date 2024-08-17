{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "sacha";
    in
    {
    
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
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
        specialArgs = {inherit inputs;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/gaming-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/gaming-laptop/home.nix;
          }
        ];
      };

      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/vm/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/vm/home.nix;
          }
        ];
      };

      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/main/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/main/home.nix;
          }
        ];
      };

      nixosConfigurations.lab = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ 
          {users.users."${username}".isNormalUser = true;}
          ./hosts/lab/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            # This should point to your home.nix path of course. For an example
            # of this see ./home.nix in this directory.
            home-manager.users."${username}" = import ./hosts/lab/home.nix;
          }
        ];
      };

    };
}
