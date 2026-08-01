{
  inputs,
  pkgs,
  config,
  ...
}:

{
  flake-file.inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-${config.nixpkgsStable}/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };

  flake.modules.nixos.nixpkgs-unstable = {
    nixpkgs.overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) config;
          system = pkgs.stdenv.hostPlatform.system;
        };
      })
    ];
  };
}
