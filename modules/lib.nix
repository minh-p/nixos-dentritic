{
  lib,
  self,
  inputs,
  ...
}:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkHomeManager = system: name: extraModules: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          self.modules.homeManager.${name}
          { nixpkgs.config.allowUnfree = true; }
        ] ++ extraModules;
      };
    };
  };
}
