{ config, pkgs, inputs, username,... }:

{
  imports =
    [
      # system
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/display_manager.nix
      ../../modules/nixos/niri.nix
      ../../modules/nixos/secure_boot.nix
      ../../modules/nixos/keyboard.nix
      ../../modules/nixos/solaar.nix
      ../../modules/nixos/piper.nix
      ../../modules/nixos/printing_and_scanning.nix

      # programming
      ../../modules/nixos/python.nix
      ../../modules/nixos/godot.nix

      # software
      ../../modules/nixos/obs.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/openfortivpn-webview.nix
      ../../modules/nixos/r2modman.nix
      ../../modules/nixos/chromium.nix
      ../../modules/nixos/music.nix
      ../../modules/nixos/gimp.nix
      ../../modules/nixos/docker.nix
      ../../modules/nixos/ventoy.nix
      ../../modules/nixos/zoom.nix
      ../../modules/nixos/qbittorrent.nix

      # gaming
      ../../modules/nixos/cockatrice.nix
      ../../modules/nixos/mtg.nix
      ../../modules/nixos/mtgo.nix
      ../../modules/nixos/emulators.nix
      ../../modules/nixos/osu_lazer.nix
      ../../modules/nixos/lutris_and_wine.nix
    ];

  # Insecure packages accepted on this host (single source of truth — nixpkgs.config
  # merges via recursiveUpdate, so this list must not be split across modules).
  #  - ventoy-qt5: pulled in by ventoy-full-qt
  #  - docker-28.5.2: flagged in nixpkgs 25.11, accepted until a patched release lands
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.10"
    "ventoy-qt5-1.1.07"
    "docker-28.5.2"
  ];

  # enable the open source kernel drivers as they are supported on my 4060
  # according to some people, this could cause problems with cuda, so I'm disabling it
  hardware.nvidia = {
    open = false;
  };
}
