{pkgs, config, lib, inputs, ... }:
{
  programs.dank-material-shell = {
    enable = true;
    niri.includes = {
      enable = true;
      override = true;
      originalFileName = "hm";
      filesToInclude = [
	"windowrules"
        "alttab"
        "binds"
        "colors"
        "layout"
        "outputs"
        "wpblur"
	"cursor"
      ];
    };
  };
}
