{
  flake.modules.nixos.emacs = { pkgs, ... }: {
    services.emacs.enable = true;
    services.emacs.package = pkgs.emacs-pgtk;
  };

  flake.modules.homeManager.base-emacs =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [
        pkgs.ripgrep
        pkgs.cmake
        pkgs.nixfmt
        pkgs.gnumake
        pkgs.libtool
        pkgs.gcc
        pkgs.pkg-config
        pkgs.ispell
        pkgs.mermaid-cli
      ];
      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
        extraPackages = epkgs: [
          epkgs.nix-mode
          epkgs.nixfmt
          epkgs.vterm
        ];
      };
    };
}
