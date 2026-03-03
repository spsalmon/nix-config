{pkgs, config, lib, inputs, ... }:
{
    programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;
  };
}
