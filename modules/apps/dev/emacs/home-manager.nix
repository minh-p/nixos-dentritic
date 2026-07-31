{
  flake.modules.homeManager.doom-emacs = { pkgs, lib, config, ... }:
    let
      doomConfig = pkgs.fetchFromGitHub {
        owner = "minh-p";
        repo = "doomemacs-config";
        rev = "fb4d8b2";
        hash = "sha256-+24cPELfiaVFoGpbR1Chn1aNun41vTHuhRv0GJKsRZs=";
      };
      doomEmacs = pkgs.fetchFromGitHub {
        owner = "doomemacs";
        repo = "core";

        # Replace these with the revision and hash you want.
        rev = "6ba99cb";
        hash = "sha256-cmQ2/kRScuwyywxWbiofdlL/KCQL9txWQecYC63uf+k=";
      };
    in {
      home.activation.installDoomEmacs =
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          target="${config.home.homeDirectory}/.config/emacs"

          if [ ! -e "$target" ]; then
            run mkdir -p "$(dirname "$target")"
            run cp -r ${doomEmacs} "$target"
            run chmod -R u+w "$target"
          fi
        '';
      home.activation.installDoomConfig =
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          target="${config.home.homeDirectory}/.config/doom"

          if [ ! -e "$target" ]; then
            run mkdir -p "$(dirname "$target")"
            run cp -r ${doomConfig} "$target"
            run chmod -R u+w "$target"
          fi
        '';

      programs.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk; # replace with pkgs.emacs-gtk if desired
        extraPackages = epkgs: [
          epkgs.nix-mode
          epkgs.nixfmt
        ];
        extraConfig = ''
          (setq standard-indent 2)
        '';
      };
    };
}
