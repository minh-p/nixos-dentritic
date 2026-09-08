{
  self,
  lib,
  config,
  ...
}:
{
  flake.modules = lib.mkMerge [
    (self.factory.user "hmp" true)
    {
      homeManager.hmp = { pkgs, config, ... }: {
        config.git = {
          name = "minh-p";
          email = "minhisverynormal@gmail.com";
        };
        imports = with self.modules.homeManager; [
          git
          ghostty
          direnv
          ohmyzsh
          pfetch

          niri

          ai
          base-emacs
          spotify
          vencord
          thunar
          library
          latex
        ];
      };
    }
  ];
  flake.homeConfigurations = config.flake.lib.mkHomeManager "x86_64-linux" "hmp" [
    {
      home = {
        username = "hmp";
        homeDirectory = "/home/hmp";
        stateVersion = "24.05";
      };
    }
  ];
}
