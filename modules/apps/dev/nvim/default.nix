{ inputs, config, ... }: {
  flake-file.inputs.nixvim.url =
    "github:nix-community/nixvim/${config.nixpkgsStable}";
  flake.modules.nixos.nvim = {
    imports = [ inputs.nixvim.nixosModules.nixvim ];
    programs.nixvim = {
      enable = true;
      colorschemes.kanagawa.enable = true;
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 4;
      };
    };
  };
}
