{ config, ... }: {
  flake-file.inputs.home-manager.url =
    "github:nix-community/home-manager/release-${config.nixpkgsStable}";
}
