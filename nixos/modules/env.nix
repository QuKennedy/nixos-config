{
    environment.sessionVariables = rec {
        TERMINAL = "alacritty";
        EDITOR = "nvim";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # NH_FLAKE = "$HOME/nixos-config";
        PATH = [
            "${XDG_BIN_HOME}"
        ];
    };
}
