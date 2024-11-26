{
  pkgs,
  ...
}: rec {
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pano
    dash-to-dock
  ];

  # To get these settings so that you can add them to your configuration after manually configuring them
  # `dconf dump /org/gnome/`
  # Another way to do this is to do `dconf watch /org/gnome` and then make the changes you want and then migrate them in as you see what they are.
  dconf.settings = {
    # First we enable every extension that we install above
    "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages);
  };
}
