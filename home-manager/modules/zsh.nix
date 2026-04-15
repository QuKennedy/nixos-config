{ config, ... }:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        # TODO: switch to zsh-fast-syntax-highlighting for faster startup
        # Blocked on: compinit insecure directories prompt from nix store paths,
        # and home-manager not supporting compinit -u natively.
        # See: github.com/nix-community/home-manager/issues/7474
        syntaxHighlighting.enable = true;

        shellAliases =
            let
                nixDir = "~/nixos-config";
                flakeDir = "~/flake";
                modulesDir = "~/nixos-config/home-manager/modules";
            in
            {
                dj = "cd ${nixDir}";
                lss = "ls -lhA --color";
                top = "htop";
                vrc = "v ${modulesDir}/zsh.nix";
                vm = "v ${modulesDir}";
                vbinds = "v ${modulesDir}/hyprland/binds.nix";
                vbar = "v ${modulesDir}/waybar/default.nix";
                pkgs = "v ${flakeDir}/nixos/packages.nix";
                vflake = "v ${flakeDir}/nixos/flake.nix";
                ca = "alacritty --class claude-term -e claude";
                sw = "git -C ~/nixos-config add . && nh os switch";
                upd = "nh os switch --update";
                hms = "nh home switch";
                r = "ranger";
                # v = "nvim";
                se = "sudoedit";
                microfetch = "microfetch && echo";
                gs = "git status";
                ga = "git add";
                gc = "git commit";
                gp = "git push";
                ".." = "cd ..";
                "..." = "cd ../..";
                "...." = "cd ../../..";
                reboot-windows = "systemctl reboot --boot-loader-entry=windows_windows.conf";
            };

        history.size = 10000;
        history.path = "${config.xdg.dataHome}/zsh/history";

        initContent = ''
              KEYTIMEOUT=1
              bindkey -M viins '^?' backward-delete-char
              bindkey -M viins '^H' backward-delete-char

              function zle-keymap-select {
                if [[ $KEYMAP == vicmd ]]; then
                  echo -ne '\e[1 q'  # block
                else
                  echo -ne '\e[5 q'  # beam
                fi
              }
              zle -N zle-keymap-select

              function zle-line-init {
                echo -ne '\e[5 q'  # beam on each new prompt
              }
              zle -N zle-line-init
              echo -ne '\e[5 q'  # beam on startup

            # TODO: if enabling tmux also re enable this
              # Start Tmux automatically if not already running. No Tmux in TTY
              # if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
              #   tmux attach-session -t default || tmux new-session -s default
              # fi

              # Start UWSM
              if uwsm check may-start > /dev/null; then
                exec systemd-cat -t uwsm_start uwsm start hyprland-uwsm.desktop
              fi
        '';
    };
}
