{ pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.claude-code.overlays.default ];  # <- add overlay


  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    anki
    # code-cursor
    vscode-fhs
    imv
    mpv
    #obs-studio
    pavucontrol
    #teams-for-linux
    #telegram-desktop
    vesktop
    nautilus
    claude-code

    # CLI utils
    grim
    slurp
    swappy
    bc
    bottom
    #brightnessctl
    cliphist
    ffmpeg
    ffmpegthumbnailer
    # fzf
    git-graph
    # grimblast
    htop
    hyprpicker
    ntfs3g
    mediainfo
    microfetch
    playerctl
    qbittorrent
    ripgrep
    showmethekey
    silicon
    udisks
    ueberzugpp
    unzip
    w3m
    wget
    wl-clipboard
    wtype
    yt-dlp
    zip

    # Coding stuff
    #openjdk23
    #nodejs
    #python311

    # WM stuff
    #libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-gtk
    # TODO maybe this explains my dupe
    # xdg-desktop-portal-hyprland

    # Other
    bemoji
    nix-prefetch-scripts
  ];
}
