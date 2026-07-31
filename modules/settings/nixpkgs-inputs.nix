{ config, ... }:

{
  flake-file.inputs = {
    nixpkgs.url =
      "https://channels.nixos.org/${config.nixpkgsStable}/nixexprs.tar.xz";
    nixpkgs-unstable.url =
      "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };
}
