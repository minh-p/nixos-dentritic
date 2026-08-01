{
  # ...other config, other config...

  flake.modules.homeManager.direnv = {
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
      };
    };
  };
}
