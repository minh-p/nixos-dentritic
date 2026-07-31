{ inputs, ... }: {
  flake-file.inputs.spicetify-nix.url =
    "github:Gerg-L/spicetify-nix"; # These programs need to be up-to-date as illegal-mods
  flake.modules.homeManager.spotify = { pkgs, ... }:
    let
      spicePkgs =
        inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];
      programs.spicetify = {
        enable = true;
	# Handled by stylix
        # theme = spicePkgs.themes.catppuccin;
        # colorScheme = "macchiato";
        windowManagerPatch = true;

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          shuffle # shuffle+ (special characters are sanitized out of ext names)
          adblock
          keyboardShortcut
          beautifulLyrics
          hidePodcasts
          history
          volumePercentage
        ];

        enabledCustomApps = with spicePkgs.apps; [
          betterLibrary
          historyInSidebar
          marketplace
        ];
      };
    };
}
