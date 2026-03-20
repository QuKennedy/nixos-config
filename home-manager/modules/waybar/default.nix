
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        # position = "top";
        position = "bottom";
        height = 20;
        modules-left = ["hyprland/workspaces"];
        # modules-center = ["hyprland/window"];
        modules-center = ["mpris"];
        # modules-right = ["hyprland/language" "custom/weather" "pulseaudio" "battery" "clock" "tray"];
        modules-right = ["cpu" "memory" "custom/weather" "clock" "tray"];
        "hyprland/workspaces" = {
          # disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
	  # https://www.tonybtw.com/tutorial/hyprland/#config-dot-jsonc
	  # https://github.com/Alexays/Waybar/wiki/Module:-CPU
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "󰈙";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            "magic" = "";
	    "urgent" = "";
          };
	  on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
	  # on-click-right = "alacritty -e btop";

          persistent-workspaces = {
            "*" = 10;
          };
        };


        "hyprland/language" = {
          format-en = "🇺🇸";
          min-length = 5;
          tooltip = false;
        };

        "custom/weather" = {
          format = " {} ";
          exec = "curl -s 'wttr.in/Brooklyn,NY?format=%c%t'";
          #exec = "curl -s 'wttr.in/Tashkent?format=%c%t'";
          interval = 300;
          class = "weather";
        };

        "mpris" = {
          player = "spotify";
          # format = "{status_icon} - {title} - {position}/{length}";
          format = "{status_icon} - {artist}: {title}";
          tooltip-format = ''
            {player}
            status: {status_icon} {position}/{length}
            title:  {title}
            artist: {artist}
            album:  {album}'';
          status-icons = {
            paused = "";
            playing = "";
            # stopped = "";
          };
          # title-len = 16;
          interval = 1;
          on-scroll-up = "playerctl previous";
          on-scroll-down = "playerctl next";
	  # align = 1;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          on-click = "pavucontrol";
        };

	"cpu" = {
          interval = 5;
          format = "    {usage}% ({load})"; # Icon: microchip
          states = {
              warning = 70;
              critical = 90;
          };
          on-click = "alacritty -e 'btop'";
	  max-length = "16";
	};

        "memory" = {
          interval = 5;
          # format = "   {}%"; # Icon: memory
          format = "   {}%"; # Icon: memory
          states = {
              warning = 70;
              critical = 90;
          };
	  on-click = "$HOME/nixos-config-reborn/scripts/screenshot.sh";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          # format = "{:%d.%m.%Y - %H:%M}";
          format = "{:%m.%d.%Y - %H:%M}";
          format-alt = "{:%A, %B %d at %R}";
          on-click = "brave calendar.google.com"; 
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };
      };
    };
  };
}
