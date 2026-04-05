{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;

  virtualisation = {
    podman.enable = false;
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  }

  users.users.sacha.extraGroups = [ "docker" ];

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
    compose2nix
  ];
}
