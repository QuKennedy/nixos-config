{ pkgs, ... }:
let
    enforce-slave = pkgs.writeShellScript "enforce-slave" ''
        socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
        ${pkgs.socat}/bin/socat - "UNIX-CONNECT:$socket" | while IFS= read -r event; do
            if [[ "$event" == openwindow* ]]; then
                # event format: openwindow>>address,workspacename,class,title
                ws_name=$(echo "$event" | cut -d',' -f2)
                clients=$(${pkgs.hyprland}/bin/hyprctl clients -j 2>/dev/null)
                claude_address=$(echo "$clients" | ${pkgs.jq}/bin/jq -r --arg ws "$ws_name" \
                    '.[] | select(.class == "claude-term" and .workspace.name == $ws and .master == true) | .address')
                if [[ -n "$claude_address" ]]; then
                    new_address=$(echo "$event" | cut -d'>' -f3 | cut -d',' -f1)
                    ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow "address:$claude_address"
                    ${pkgs.hyprland}/bin/hyprctl dispatch layoutmsg slave
                    ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow "address:$new_address"
                fi
            fi
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
            Restart = "always";
            RestartSec = 3;
        };
        Install.WantedBy = [ "hyprland-session.target" ];
    };
}
