{
  flake.modules.nixos.emacs = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.emacs-pgtk ];
    services.emacs.enable = true;
  };
}
