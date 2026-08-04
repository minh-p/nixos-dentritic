{
  flake.modules.homeManager.vencord = { pkgs, ... }: {
    home.packages = [ pkgs.vesktop ];
  };
  flake.modules.homeManager.discord = { pkgs, ... }: {
    home.packages = [ pkgs.discord ];
  };
}
