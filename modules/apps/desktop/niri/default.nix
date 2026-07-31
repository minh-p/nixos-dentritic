{self, inputs, ...}: {
  flake-file.inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.modules.homeManager.niri = {
    programs.niri = {
      settings = {
        binds = {
	  "Mod+T".action.spawn = "ghostty";
	};
      };
    };
  };
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };
}
