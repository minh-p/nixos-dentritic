{
  flake.modules.nixos.emacs = { pkgs, ... }: {
    services.emacs.enable = true;
  };
}
