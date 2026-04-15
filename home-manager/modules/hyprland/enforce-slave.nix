{ pkgs, ... }:
let
    enforce-slave = pkgs.writeShellScript "enforce-slave" ''
        find_socket() {
            local dir="/run/user/$UID/hypr"
            if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
                echo "$dir/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
            else
                local instance
                instance=$(ls "$dir" 2>/dev/null | head -1)
                [[ -n "$instance" ]] && echo "$dir/$instance/.socket2.sock"
            fi
        }

        while true; do
            socket=$(find_socket)
            if [[ -z "$socket" || ! -S "$socket" ]]; then
                sleep 2
                continue
            fi

            ${pkgs.socat}/bin/socat -u "UNIX-CONNECT:$socket" - 2>/dev/null | while IFS= read -r event; do
                [[ "$event" != openwindow* ]] && continue

                echo "[enforce-slave] event: $event" >> /tmp/enforce-slave.log

                # event format: openwindow>>address,workspacename,class,title
                IFS=',' read -r new_addr ws_name rest <<< "''${event#*>>}"

                echo "[enforce-slave] new_addr=$new_addr ws_name=$ws_name" >> /tmp/enforce-slave.log

                clients=$(${pkgs.hyprland}/bin/hyprctl clients -j 2>/dev/null)

                # master = leftmost window (smallest x) on the workspace
                claude_x=$(echo "$clients" | ${pkgs.jq}/bin/jq -r --arg ws "$ws_name" \
                    '.[] | select(.class == "claude-term" and .workspace.name == $ws) | .at[0]')
                min_x=$(echo "$clients" | ${pkgs.jq}/bin/jq -r --arg ws "$ws_name" \
                    '[.[] | select(.workspace.name == $ws) | .at[0]] | min')

                echo "[enforce-slave] claude_x=$claude_x min_x=$min_x" >> /tmp/enforce-slave.log

                if [[ -n "$claude_x" && "$claude_x" == "$min_x" ]]; then
                    ${pkgs.hyprland}/bin/hyprctl --batch \
                        "dispatch focuswindow address:$new_addr ; dispatch layoutmsg swapwithmaster"
                    echo "[enforce-slave] swapped" >> /tmp/enforce-slave.log
                fi
            done

            sleep 1
        done
    '';
in
{
    systemd.user.services.enforce-slave = {
        Unit = {
            Description = "Keep claude-term windows as slaves in Hyprland master layout";
            After = [ "hyprland-session.target" ];
        };
        Service = {
            ExecStart = "${enforce-slave}";
            Restart = "on-failure";
        };
        Install.WantedBy = [ "hyprland-session.target" ];
    };
}
