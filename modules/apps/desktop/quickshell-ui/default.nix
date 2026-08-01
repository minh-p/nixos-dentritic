{
  flake.modules.homeManager.quickshell-ui = { pkgs, ... }: {
    home.packages = [ pkgs.quickshell ];
  };
}
