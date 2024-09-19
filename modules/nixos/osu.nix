{ inputs, lib, config, pkgs, ... }:
{
  # These are all the dependencies needed to install osu stable using the script at
  # https://github.com/NelloKudo/osu-winello
  environment.systemPackages = with pkgs; [
    zenity
    inputs.umu.packages.${pkgs.system}.umu
    mesa
  ];
}
