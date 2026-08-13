{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
	iosevka
        nerd-fonts.jetbrains-mono
        dejavu_fonts
        font-awesome_5
	nerd-fonts.symbols-only
      ];
    };
  };
}
