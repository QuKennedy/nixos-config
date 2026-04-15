{
    pkgs,
    inputs,
    ...
}:
let
    spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
    imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

    programs.spicetify = {
        enable = true;
        # theme = spicetifyPkgs.themes.text;

        enabledExtensions = with spicetifyPkgs.extensions; [
            keyboardShortcut
            volumePercentage
            hidePodcasts
            # shuffle
            # seekSong
            # adblock
            # queueTime
            # autoSkipVideo
            # playNext
        ];
    };
}
