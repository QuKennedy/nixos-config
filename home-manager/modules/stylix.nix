{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    texlivePackages.hebrew-fonts
    noto-fonts-color-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
    #(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # TODO: not sure if needed https://github.com/hmajid2301/nixicle/blob/14be6cffdea42ef58619b7fa9b10b1697ab96172/modules/home/styles/stylix/default.nix#L12
    # Force base16 colors instead of extracting from image
    override = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets = {
      waybar.enable = false;
      wofi.enable = true;
      hyprland.enable = false;
      hyprlock.enable = false;
    };

#    targets = {
#      neovim.enable = true;
#      waybar.enable = true;
#      wofi.enable = true;
#      hyprland.enable = true;
#      hyprlock.enable = true;
#    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 20;
        applications = 12;
        popups = 12;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    image = pkgs.fetchurl {
      url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
      sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    };
  };
}
