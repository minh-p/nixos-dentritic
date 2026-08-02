{ inputs, config, ... }: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix/release-${config.nixpkgsStable}";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.stylix = { lib, pkgs, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      image = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/8x/wallhaven-8x95oy.png";
        name = "porsche911-wallpaper.png";
        hash = "sha256-NkM4Q4sXKWjUqak9bRu9K2ijL1OptQHLoVdzV7n0bmo=";
      };
      targets = {
        kmscon = {
          enable = false;
          colors.enable = false;
          fonts.enable = false;
        };
        nixvim = {
          enable = false;
        };
      };
    };
  };
}
