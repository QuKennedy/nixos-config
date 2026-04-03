{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style) ";
        style = "bold purple";
      };
      username = {
        show_always = true;
        format = "[$user]($style)@";
      };
      directory = {
        read_only = " 🔒";
        truncation_symbol = "…/";
      };
    };
  };
}
