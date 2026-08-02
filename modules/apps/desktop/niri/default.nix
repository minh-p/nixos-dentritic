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
    let
      quickshell-ui-dir = "${../quickshell-ui}";
    in
    {
      programs.niri = {
        package = pkgs.niri;
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
            {
              argv = [
                "${pkgs.quickshell}/bin/qs"
                "-p"
                "${quickshell-ui-dir}"
              ];
            }
          ];
          cursor = {
            size = 6;
          };
          layout = {
            gaps = 5;
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
            "Mod+Shift+Return" = {
              hotkey-overlay.title = "Spawn terminal";
              action.spawn = "ghostty";
            };
            "Mod+Shift+B" = {
              hotkey-overlay.title = "Spawn browser";
              action.spawn = "firefox";
            };
            "Mod+Shift+I".action.show-hotkey-overlay = [ ];
            "Mod+Shift+Q".action.quit.skip-confirmation = false;
            "Mod+Shift+E" = {
              hotkey-overlay.title = "Spawn emacs";
              action.spawn = [
                "emacsclient"
                "-nc"
              ];
            };
            "Mod+O" = {
              hotkey-overlay.title = "Toggle bar";
              action = {
                spawn = [
                  "${pkgs.quickshell}/bin/qs"
                  "-p"
                  "${quickshell-ui-dir}"
                  "ipc"
                  "call"
                  "root"
                  "toggleBar"
                ];
              };
            };
            "Mod+Q".action.close-window = [ ];
            "Mod+H".action.focus-column-left = [ ];
            "Mod+L".action.focus-column-right = [ ];
            "Mod+J".action.focus-window-down = [ ];
            "Mod+K".action.focus-window-up = [ ];
            "Mod+Left".action.focus-column-left = [ ];
            "Mod+Right".action.focus-column-right = [ ];
            "Mod+Down".action.focus-window-down = [ ];
            "Mod+Up".action.focus-window-up = [ ];

            "Mod+Shift+L".action.focus-monitor-right = [ ];
            "Mod+Shift+H".action.focus-monitor-left = [ ];
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
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-right = 12.0;
                top-left = 12.0;
              };
              clip-to-geometry = true;
            }
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
  flake.modules.nixos.niri = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri;
  };
}
