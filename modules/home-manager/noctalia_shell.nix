{pkgs, config, lib, inputs, ... }:
{
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;
  };
}
