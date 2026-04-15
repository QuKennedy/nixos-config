{ pkgs, ... }:
let
    booksDir = "$HOME/Downloads/books";
    booksScript = pkgs.writeScriptBin "open_books" ''
        #!/bin/sh

        BOOKS_DIR="${booksDir}"

        BOOK=$(find "$BOOKS_DIR" -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) | wofi --dmenu --prompt "Select a book" --width 1200 --height 400)

        if [[ -n "$BOOK" ]]; then
            zathura "$BOOK" &
        else
            echo "No book selected."
        fi
    '';
in
{
    home.packages = [ booksScript ];

    wayland.windowManager.hyprland.settings = {
        bind = [
            "$mainMod,       T, exec, $terminal"
            "$mainMod,       W, killactive,"
            "$mainMod,       TAB, workspace, previous"
            "$mainMod,       F, fullscreen,"
            # "$mainMod,       O, exit,"
            "$mainMod,       R, exec, $fileManager"
            "$mainMod SHIFT, F, togglefloating,"
            "$mainMod,       D, exec, $menu --show drun"
            # "$mainMod,       P, pin,"
            # "$mainMod,       J, togglesplit,"
            # "$mainMod,       E, exec, bemoji -cn"
            "$mainMod,       V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy"
            "$mainMod,       B, exec, brave"
            "$mainMod SHIFT, B, exec, pkill -SIGUSR2 waybar"
            # "$mainMod,       B, exec, pkill -SIGUSR2 waybar"
            # "$mainMod SHIFT, B, exec, pkill -SIGUSR1 waybar"
            "$mainMod SHIFT, X, exec, loginctl lock-session"
            # "$mainMod,       L, exec, loginctl lock-session"
            "$mainMod,       P, exec, hyprpicker -an"
            "$mainMod,       N, exec, swaync-client -t"
            ", Print, exec, grimblast --notify --freeze copysave area"

            # Moving focus
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            # Moving windows
            "$mainMod SHIFT, H,  swapwindow, l"
            "$mainMod SHIFT, L, swapwindow, r"
            "$mainMod SHIFT, K,    swapwindow, u"
            "$mainMod SHIFT, J,  swapwindow, d"

            # Switching workspaces
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Moving windows to workspaces
            "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
            "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
            "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
            "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
            "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
            "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
            "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
            "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
            "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
            "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

            # Scratchpad
            "$mainMod,       S, togglespecialworkspace,  magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];

        # Allowing repeat
        binde = [
            # Resizeing windows           X  Y
            "$mainMod, Y, resizeactive, -20 0"
            "$mainMod, O, resizeactive,  20 0"
            "$mainMod, I, resizeactive,  0 -20"
            "$mainMod, U, resizeactive,  0  20"
            "$mainMod, up, exec, playerctl --player spotify volume .01+"
            "$mainMod, down, exec, playerctl --player spotify volume .01-"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
            ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            # "$mainMod, bracketright, exec, brightnessctl s 10%+"
            # "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
        ];

        # Audio playback
        bindl = [
            ", XF86AudioNext,  exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay,  exec, playerctl play-pause"
            ", XF86AudioPrev,  exec, playerctl previous"
        ];
    };
}
