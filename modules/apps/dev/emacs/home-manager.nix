{
  flake.modules.homeManager.doom-emacs = { pkgs, lib, config, ... }:
    let
      doomConfig = pkgs.fetchFromGitHub {
        owner = "minh-p";
        repo = "doomemacs-config";
        rev = "fb4d8b2";
        hash = lib.fakeHash;
      };
      doomEmacs = pkgs.fetchFromGitHub {
        owner = "doomemacs";
        repo = "core";

        # Replace these with the revision and hash you want.
        rev = "6ba99cb";
        hash = lib.fakeHash;
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
    };
}
