{ config, pkgs, inputs, username,... }:

{
  imports =
    [
      ../default/pkgs.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/obs.nix
      ../../modules/nixos/openfortivpn.nix
      ../../modules/nixos/podman.nix
      ../../modules/nixos/r2modman.nix
      ../../modules/nixos/chromium.nix
      ../../modules/nixos/python.nix
      ../../modules/nixos/osu_lazer.nix
      ../../modules/nixos/lutris_and_wine.nix
      ../../modules/nixos/music.nix
      # ../../modules/nixos/gimp.nix
      ../../modules/nixos/emulators.nix
      ../../modules/nixos/krita.nix
      ../../modules/nixos/docker.nix
      ../../modules/nixos/quickemu.nix
      ../../modules/nixos/virtualbox.nix
      ../../modules/nixos/vscode.nix
      ../../modules/nixos/secure_boot.nix
      ../../modules/nixos/ventoy.nix
    ];

  environment.systemPackages = with pkgs; [
    godot_4
    audacity
    xclicker
    clinfo
    gpu-viewer
  ];
  

  # enable the open source kernel drivers as they are supported on my 4060
  # according to some people, this could cause problems with cuda, so I'm disabling it
  hardware.nvidia = {
    open = false;
  };
}
