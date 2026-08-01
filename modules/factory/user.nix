{ self, ... }: {
  flake.factory.user = username: isAdmin: {
    nixos.${username} =
      {
        lib,
        pkgs,
        config,
        ...
      }:
      {
        users.users.${username} = {
          isNormalUser = true;
          home = "/home/${username}";
          extraGroups = lib.optionals isAdmin [ "wheel" ];
          shell = pkgs.zsh;
        };
        programs.zsh.enable = true;

        home-manager.users."${username}" = {
          home = {
            stateVersion = config.system.stateVersion;
            homeDirectory = "/home/${username}";
          };
          imports = [ self.modules.homeManager."${username}" ];
        };
      };
  };
}
