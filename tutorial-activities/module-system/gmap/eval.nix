let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import <nixpkgs> { };
in pkgs.lib.evalModules {
  modules = [
    ({ config, ... }: { config._module.args = { inherit pkgs; }; })
    ./default.nix
  ];
}
