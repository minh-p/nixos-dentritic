{ self, lib, config, ... }: {
  flake.modules = lib.mkMerge [
    (self.factory.user "hmp" true)
    {
      homeManager.hmp = { pkgs, ... }: {
        imports = with self.modules.homeManager; [ ];
      };
    }
  ];
  flake.homeConfigurations =
    config.flake.lib.mkHomeManager "x86_64-linux" "hmp";
}
