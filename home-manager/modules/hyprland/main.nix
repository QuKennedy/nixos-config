{ inputs, ... }: {
  imports = [ inputs.hyprland.homeManagerModules.default ];
# TODO figure out auto login: https://github.com/brycekormylo/dotfiles/blob/6b41cec8f4a0d3ddda89170ba1069371de73cb06/system/hyprland.nix#L54
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",3840x2160@160,auto,1";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "$terminal -e sh -c 'ranger'";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      # "[workspace special:magic silent] alacritty --working-directory /home/beeper/nixos-config"
      # "[workspace 10 silent] brave --app=https://messages.google.com/web/conversations"
      # "[workspace 10 silent] vesktop"
      # "[workspace 8 silent] qbittorrent"
      # "[workspace 7 silent] spotify"
      # "[workspace 7 silent] brave --app=https://www.youtube.com/"
      # "[workspace 6 silent] alacritty --working-directory /home/beeper/nixos-config"
      # "[workspace 4 silent] alacritty -e v"
      # "[workspace 1 silent] brave"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 5;

        "col.active_border" = "rgba(cba6f7ff) rgba(89b4faff) 45deg";
        "col.inactive_border" = "rgba(313244ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "us";
        kb_options = "";
	repeat_delay = 220;
	repeat_rate = 50;
        follow_mouse = 1;
      };

      #gestures = {
      #  workspace_swipe = true;
      #  workspace_swipe_invert = false;
      #  workspace_swipe_forever	= true;
      #};

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrule = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        # "workspace 3,class:(obsidian)"
        # TODO set up vencord
        "workspace 7,class:(spotify)"
        "workspace 8,class:(qbittorrent)"
        "workspace 10,class:(vesktop)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];

      workspace = [
        # "w[tv1], gapsout:0, gapsin:0"
        # "f[1], gapsout:0, gapsin:0"
        "special:magic, on-created-empty: alacritty --working-directory /home/beeper/nixos-config"
        "10, on-created-empty: brave --app=https://messages.google.com/web/conversations && vesktop"
        "9, on-created-empty: brave --app=https://calendar.google.com/calendar/u/0/r"
        "8, on-created-empty: qbittorrent"
        "7, on-created-empty: spotify && brave --app=https://www.youtube.com/"
        "6, on-created-empty: alacritty --working-directory /home/beeper/nixos-config"
        "4, on-created-empty: alacritty -e v"
        "3, on-created-empty: nautilus"
        "2, on-created-empty: brave --app=https://claude.ai/chat"
        "1, on-created-empty: brave"
        # "special:scratchpad, on-created-empty:alacritty"
      ];
    };
  };
}
