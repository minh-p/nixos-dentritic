{ self, lib, config, ... }: {
  flake.modules = lib.mkMerge [
    (self.factory.user "hmp" true)
    {
      homeManager.hmp = { pkgs, config, ... }: {
        config.git = {
          name = "minh-p";
          email = "minhisverynormal@gmail.com";
        };
        imports = with self.modules.homeManager; [ doom-emacs git spotify ];
      };
    }
  ];
  flake.homeConfigurations =
    config.flake.lib.mkHomeManager "x86_64-linux" "hmp";
}
