{
  flake.modules.homeManager.git = { config, ... }: {
    programs.git = {
      enable = true;
      settings.user = {
        name = config.git.name;
        email = config.git.email;
      };
    };
  };
}
