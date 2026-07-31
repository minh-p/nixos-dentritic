{ lib, ... }: {
  flake.modules.homeManager.git = {
    options.git = lib.mkOption {
      description = "Git identity";
      type = lib.types.attrsOf lib.types.str;
      default = {
        name = "nobody";
        email = "nobody@email.com";
      };
    };
  };
}
