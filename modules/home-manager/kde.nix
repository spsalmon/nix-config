{pkgs, config, lib, inputs, ... }:
{
 programs.plasma = {
    enable = true;

    #
    # Some high-level settings:
    #
    workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      lookAndFeel = "org.kde.breezedark.desktop";
      #cursorTheme = "Breeze";
      #iconTheme = "Breeze-Dark";
      wallpaper = "/home/sacha/wallpaper/gybe_fsharp.jpg";
    };

    hotkeys.commands."launch-alacritty" = {
      name = "Launch Alacritty";
      key = "Meta+T";
      command = "alacritty";
    };

    fonts = {
      general = {
        family = "IBM Plex Mono";
        pointSize = 10;
      };
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          # We can configure the widgets by adding the name and config
          # attributes. For example to add the the kickoff widget and set the
          # icon to "nix-snowflake-white" use the below configuration. This will
          # add the "icon" key to the "General" group for the widget in
          # ~/.config/plasma-org.kde.plasma.desktop-appletsrc.
          {
            name = "org.kde.plasma.kicker";
            config = {
              General.icon = "nix-snowflake-white";
            };
          }
          # Adding configuration to the widgets can also for example be used to
          # pin apps to the task-manager, which this example illustrates by
          # pinning dolphin and konsole to the task-manager by default.
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          # If no configuration is needed, specifying only the name of the
          # widget will add them with the default configuration.
          "org.kde.plasma.marginsseparator"
          # If you need configuration for your widget, instead of specifying the
          # the keys and values directly using the config attribute as shown
          # above, plasma-manager also provides some higher-level interfaces for
          # configuring the widgets. See modules/widgets for supported widgets
          # and options for these widgets. The widgets below shows two examples
          # of usage, one where we add a digital clock, setting 12h time and
          # first day of the week to sunday and another adding a systray with
          # some modifications in which entries to show.
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
              # And explicitly hide networkmanagement and volume
              hidden = [
                "org.kde.plasma.bluetooth"
              ];
            };
          }
        ];
        hiding = "none";
      }
      # Global menu at the top
      #{
      #  location = "top";
      #  height = 26;
      #  widgets = [
      #    "org.kde.plasma.appmenu"
      #  ];
      #  hiding = "autohide";
      #}
    ];


    #
    # Some mid-level settings:
    #
    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };

    # touchpad settings
    input.touchpads = [
      # touchpad setting for gaming laptop
      {
        disableWhileTyping = true;
        enable = true;
        naturalScroll = true;
        tapToClick = true;
        vendorId = "04f3";
        productId = "3049";
        name = "ELAN1200:00 04F3:3049 Touchpad";
      }
    ];

    powerdevil.AC.autoSuspend.action = "nothing";

    #
    # Some low-level settings:
    #
    configFile = {
      #baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      #kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "SF";
      kwinrc.Desktops.Number = {
        value = 8;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      kscreenlockerrc = {
        Greeter.WallpaperPlugin = "org.kde.potd";
        # To use nested groups use / as a separator. In the below example,
        # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
        "Greeter/Wallpaper/org.kde.potd/General".Provider = "bing";
      };
    };
  };
}
