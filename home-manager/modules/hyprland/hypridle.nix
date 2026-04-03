# TODO: remove all locking on idle — no hyprlock, no loginctl lock-session. monitor sleep only.
# TODO: monitor takes ~10s to wake from dpms off — investigate faster resume (wlr-randr? hyprland dpms quirk?)
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
       #{
       #  timeout = 180;
       #  on-timeout = "brightnessctl -s set 30";
       #  on-resume = "brightnessctl -r";
       #}
        {
          timeout = 1000;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1000;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1200;
          on-timeout = "sysemctl suspend"; # typo: systemctl
        }
      ];
    };
  };
}
