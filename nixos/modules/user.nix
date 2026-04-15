{
    pkgs,
    user,
    ...
}:
{
    programs.zsh.enable = true;

    users = {
        defaultUserShell = pkgs.zsh;
        users.${user} = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "networkmanager"
                "input"
            ];
        };
    };

    security.sudo.extraRules = [
        {
            users = [ user ];
            commands = [
                {
                    command = "/run/current-system/sw/bin/nh";
                    options = [ "NOPASSWD" ];
                }
            ];
        }
    ];

    services.getty.autologinUser = user;
}
