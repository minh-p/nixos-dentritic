{ self, inputs, ... }: {
  flake-file.inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.modules.homeManager.niri =
    {
      osConfig,
      pkgs,
      lib,
      ...
    }:
    {
      programs.niri = {
        settings = {
          spawn-at-startup = [
            {
              argv = [
                "${pkgs.swaybg}/bin/swaybg"
                "--image"
                "${osConfig.stylix.image}"
                "--mode"
                "fill"
              ];
            }
          ];
          cursor = {
            size = 12;
          };
          input = {
            focus-follows-mouse.enable = true;
            keyboard = {
              xkb = {
                layout = "us";
                options = "caps:swapescape";
              };
              repeat-delay = 300;
              repeat-rate = 50;
            };
          };
          outputs = lib.listToAttrs (
            lib.forEach osConfig.myHost.peripherals.displays (info: {
              name = info.name;
              value = {
                transform = {
                  rotation = info.rotation;
                };
                position = info.position;
              };
            })
          );

          binds = {
            "Mod+Shift+Return".action.spawn = "ghostty";
            "Mod+Shift+B".action.spawn = "firefox";
            "Mod+Shift+I".action.show-hotkey-overlay = [ ];
            "Mod+Shift+Q".action.quit.skip-confirmation = false;
            "Mod+Shift+E".action.spawn = [
              "emacsclient"
              "-nc"
            ];
            "Mod+Q".action.close-window = [ ];
            "Mod+H".action.focus-column-left = [ ];
            "Mod+L".action.focus-column-right = [ ];
            "Mod+J".action.focus-window-down = [ ];
            "Mod+K".action.focus-window-up = [ ];
            "Mod+Left".action.focus-column-left = [ ];
            "Mod+Right".action.focus-column-right = [ ];
            "Mod+Down".action.focus-window-down = [ ];
            "Mod+Up".action.focus-window-up = [ ];

            "Mod+Shift+Right".action.focus-monitor-right = [ ];
            "Mod+Shift+Left".action.focus-monitor-left = [ ];
            "Mod+Shift+J".action.focus-workspace-down = [ ];
            "Mod+Shift+K".action.focus-workspace-up = [ ];
            "Mod+Print".action.screenshot-screen = {
              show-pointer = false;
            };
          };
          hotkey-overlay = {
            hide-not-bound = true;
          };
          window-rules = [
            {
              matches = [ { app-id = "^com\\.mitchellh\\.ghostty$"; } ];
              draw-border-with-background = false;
              opacity = 0.95;
            }
            {
              matches = [ { app-id = "^emacs$"; } ];
              draw-border-with-background = false;
              opacity = 0.95;
            }
          ];
        };
      };
    };
  flake.modules.nixos.niri = {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
  };
}
