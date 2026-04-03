{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 1050;
      height = 675;
    };
  };

  # home.file.".config/wofi/style.css".source = ./style.css;
}
