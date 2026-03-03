{ config, pkgs, ... }:

{
  # Enable X session management via HM
  xsession.enable = true;

  # Openbox (HM writes rc.xml/menu.xml/autostart)
  xsession.windowManager.openbox = {
    enable = true;

    # Start panel + wallpaper + optional extras
    autostart = [
      "feh --bg-scale ~/Pictures/wallpaper.jpg"
      "picom"
      "tint2"
    ];

    # Right-click menu
    menu = ''
      <openbox_menu>
        <menu id="root-menu" label="Openbox">
          <item label="Terminal">
            <action name="Execute"><command>kitty</command></action>
          </item>
          <item label="File Manager">
            <action name="Execute"><command>thunar</command></action>
          </item>

          <separator/>

          <item label="Launcher">
            <action name="Execute"><command>rofi -show drun</command></action>
          </item>

          <separator/>

          <item label="Reconfigure">
            <action name="Reconfigure"/>
          </item>
          <item label="Exit">
            <action name="Exit"/>
          </item>
        </menu>
      </openbox_menu>
    '';

    # Keybind (Super+Space) for rofi
    rc = {
      keyboard.keybind = [
        {
          key = "W-space";
          action = "Execute";
          command = "rofi -show drun";
        }
      ];
    };
  };

  # tint2: manage ~/.config/tint2/tint2rc
  xdg.configFile."tint2/tint2rc".text = ''
    # Vertical left panel/dock
    panel_position = left center vertical
    panel_size = 52 100%
    panel_margin = 0 0
    panel_padding = 6 6 6
    panel_items = TSC

    # Taskbar
    taskbar_mode = single_desktop
    taskbar_padding = 2 4 2
    taskbar_hide_inactive_tasks = 0

    # Systray
    systray_padding = 4 4 4

    # Clock
    time1_format = %H:%M
    time1_font = Sans 10
  '';

  # Optional: rofi theme/config (minimal)
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      drun-display-format: "{name}";
    }
  '';
}