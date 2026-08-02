{
  flake.modules.nixos.emacs = { pkgs, ... }: {
    services.emacs.enable = true;
    services.emacs.package = pkgs.emacs-pgtk;
  };
}
