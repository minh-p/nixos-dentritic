let
  pkgs = import <nixpkgs> { };
  result = pkgs.lib.evalModules { modules = [ ./config.nix ./options.nix ]; };
in result.config
