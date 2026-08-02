{
  flake.modules.homeManager.ohmyzsh = {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "amuse";
      };
    };
  };
}
