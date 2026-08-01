{ inputs, config, ... }: {
  flake-file.inputs.home-manager.url = "github:nix-community/home-manager/release-${config.nixpkgsStable}";
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
