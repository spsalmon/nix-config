{ config, pkgs, lib, ... }:

let
  colorScheme = import ../../color-schemes/material-dark-yellow.nix;
  font = "IBM Plex Mono";
in {
  home.packages = with pkgs; [ jq radeontop ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        height = 32; # Waybar height
        width = 48; # Waybar width
        # Choose the order of the modules
        modules-left = [ "custom/power" "pulseaudio" "backlight"];
        modules-center = [ "hyprland/workspaces" "hyprland/window" "tray" ];
        modules-right = [ "battery" "battery#bat2" "cpu" "temperature" "network" "bluetooth" "clock" ];
        "hyprland/workspaces" = {
          disable-scroll = true;
          disable-markup  = false;
          all-outputs = false;
          format = "  {icon}  ";
          #format ="{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            "focused" = "";
            "default" = "";
          };
        };
        "hyprland/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "hyprland/language" = {
          format = "{}";
          max-length = 50;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y/%d/%m} ";
          format = "{:%H:%M} ";
        };
        "cpu" = {
          format = "{usage}%  CPU";
        };
        "memory" = {
          format = "{}% ";
        };
        "disk" = {
          format = "{}% ";
          tooltip-format = "{used} / {total} used";
        };
        "temperature" = {
          # thermal-zone = 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C ";
          format = "{temperatureC}°C ";
        };
        "backlight" = {
          # device = "acpi_video1";
          format = "{percent}% {icon}";
          states = [ "0" "50" ];
        };
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          format-icons = [ "" "" "" "" "" ];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          # "interface" = "wlp2s0"; # (Optional) To force the use of this interface
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ifname} = {ipaddr}/{cidr} ";
          "format-disconnected" = "Disconnected ⚠";
          "interval" = 7;
        };
        "bluetooth" = {
          format = "<b>{icon}</b>";
          format-alt = "{status} {icon}";
          interval = 30;
          format-icons = {
            "enabled" = "";
            "disabled" = "";
          };
          tooltip-format = "{}";
        };
        "pulseaudio" = {
          #"scroll-step" = 1;
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          "on-click" = "pavucontrol";
        };
      };
    };
  };
}

