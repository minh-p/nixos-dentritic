{
  flake.modules.homeManager.library = { pkgs, ... }: {
    home.packages = [
      pkgs.calibre
      pkgs.sioyek
    ];
  };
}
