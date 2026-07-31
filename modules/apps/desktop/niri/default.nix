{self, inputs, ...}: {
  flake-file.inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.modules.homeManager.niri = {osConfig, pkgs, ...}: {
    programs.niri = {
      settings = {
	spawn-at-startup = [
	  {argv = [
	    "${pkgs.swaybg}/bin/swaybg"
	    "--image"
	    "${osConfig.stylix.image}"
	    "--mode" "fill"
	  ];}
	];
        cursor = {
          size = 12;
        }; 
	input = {
  	  keyboard = {
	    xkb = {
  	      layout = "us";
  	      options = "caps:swapescape";
	    };
	    repeat-delay = 300;
	    repeat-rate = 50;
	  };
	};
        binds = {
	  "Mod+Shift+Return".action.spawn = "ghostty";
	  "Mod+Shift+B".action.spawn = "firefox";
	  "Mod+Shift+I".action.show-hotkey-overlay = [];
	  "Mod+Shift+E".action.quit.skip-confirmation = false;
	  "Mod+Q".action.close-window = [];
	  "Mod+H".action.focus-column-left = [];
	  "Mod+L".action.focus-column-right = [];
	  "Mod+J".action.focus-window-down = [];
	  "Mod+K".action.focus-window-up = [];
	  "Mod+Left".action.focus-column-left = [];
	  "Mod+Right".action.focus-column-right = [];
	  "Mod+Down".action.focus-window-down = [];
	  "Mod+Up".action.focus-window-up = [];
	};
	hotkey-overlay = {
	  hide-not-bound = true;
	};
      };
    };
  };
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };
}
