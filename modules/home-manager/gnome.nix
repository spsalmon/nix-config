{
  pkgs,
  ...
}: rec {
  home.packages = with pkgs.gnomeExtensions; [
    # blur-my-shell
    clipboard-indicator
    dash-to-dock
  ];

  # To get these settings so that you can add them to your configuration after manually configuring them
  # `dconf dump /org/gnome/`
  # Another way to do this is to do `dconf watch /org/gnome` and then make the changes you want and then migrate them in as you see what they are.
  dconf.settings = {
    # First we enable every extension that we install above
    "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages);

    "org/gnome/shell" = {
      disabled-extensions = [ "blur-my-shell@aunetx" ];
      favorite-apps = [ "firefox.desktop" "vesktop.desktop" "Alacritty.desktop" "emacs.desktop" "org.gnome.Nautilus.desktop" "steam.desktop" ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = false;
      apply-custom-theme = false;
      background-opacity = 0.95;
      click-action = "minimize-or-previews";
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 0.9;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      middle-click-action = "launch";
      multi-monitor = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
      preview-size-scale = 0.33;
      running-indicator-style = "DOTS";
      scroll-action = "cycle-windows";
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
      show-apps-at-top = true;
      show-show-apps-button = false;
      show-trash = false;
      transparency-mode = "FIXED";
    };
  };
}
