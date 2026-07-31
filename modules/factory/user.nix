{ self, ... }: {
  flake.factory.user = username: isAdmin: {
    nixos.${username} = { lib, pkgs, ... }: {
      users.users.${username} = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = lib.optionals isAdmin [ "wheel" ];
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;

      home-manager.users."${username}" = { config, ... }: {
        home.homeDirectory = "/home/hmp/${config.home.username}";
        imports = [ self.modules.homeManager."${username}" ];
      };
    };
  };
}
