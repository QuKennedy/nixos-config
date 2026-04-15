{
    programs.fzf = {
        enable = true;
        enableZshIntegration = true;

        defaultCommand = "fd --type file --type directory --exclude store --exclude var --exclude sys --exclude run --exclude tmp";
        fileWidgetCommand = "fd --type file --type directory --exclude store --exclude var --exclude sys --exclude run --exclude tmp";
    };
    programs.fd.enable = true;
}
