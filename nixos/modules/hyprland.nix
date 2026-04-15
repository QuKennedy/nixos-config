{
    # TODO     https://github.com/brycekormylo/dotfiles/blob/6b41cec8f4a0d3ddda89170ba1069371de73cb06/system/hyprland.nix#L54
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        # TODO: maybe i need to set this to true in the future?
        # xwayland.enable = false;
    };

    security.pam.services.hyprlock = { };
}
