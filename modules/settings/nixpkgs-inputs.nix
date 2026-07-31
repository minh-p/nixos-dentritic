{ config, ... }:

{
  flake-file.inputs = {
    nixpkgs.url =
      "https://channels.nixos.org/nixos-${config.nixpkgsStable}/nixexprs.tar.xz";
    nixpkgs-unstable.url =
      "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };
}
