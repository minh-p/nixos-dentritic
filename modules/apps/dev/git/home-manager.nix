{ config, ... }: {
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings.user = {
        name = config.git.name;
        email = config.git.email;
      };
    };
  };
}
