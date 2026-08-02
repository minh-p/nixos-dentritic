{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        dejavu_fonts
        font-awesome_5
      ];
    };
  };
}
