{ inputs, ... }: {
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim/nixos-26.05";
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
