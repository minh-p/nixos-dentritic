{
  flake.modules.homeManager.zoom = { pkgs, ... }: {
    home.packages = [ pkgs.unstable.zoom ];
  };
}
