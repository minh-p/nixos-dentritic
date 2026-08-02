{ lib, config, ... }: {
  options = {
    nixpkgsStable = lib.mkOption {
      description = "Stable nixpkgs other flake inputs follow";
      type = lib.types.str;
      default = "26.05";
    };
  };
  config = {
    flake.modules.nixos.options = {
      options = {
        myHost = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "NixOS hostname";
            default = "nixos";
          };

          vendors = lib.mkOption {
            description = "The host's CPU and GPU vendors.";
            type = lib.types.submodule {
              options = {
                cpu = lib.mkOption {
                  type = lib.types.enum [
                    "amd"
                    "intel"
                  ];
                };

                gpu = lib.mkOption {
                  type = lib.types.enum [
                    "amd"
                    "intel"
                    "nvidia"
                  ];
                };
              };
            };
          };
          diskLabels = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
          extraBootKernModules = lib.mkOption {
            description = "Extra kernel modules to pass to boot";
            type = lib.types.listOf lib.types.str;
          };
          peripherals = lib.mkOption {
            description = "What peripherals exist? Important especially for laptops.";
            type = lib.types.submodule {
              options = {
                displays = lib.mkOption {
                  description = "Display additional information like transformations.";
                  type = lib.types.listOf (
                    lib.types.submodule {
                      options = {
                        name = lib.mkOption {
                          description = "Output name. Found with wlr-randr";
                          type = lib.types.str;
                        };

                        rotation = lib.mkOption {
                          description = "Degrees to rotate output in counter-clockwise direction";
                          type = lib.types.enum [
                            0
                            90
                            180
                            270
                          ];
                          default = 0;
                        };

                        position = lib.mkOption {
                          description = "Degrees to position outputs";
                          type = lib.types.nullOr (
                            lib.types.submodule {
                              options = {
                                x = lib.mkOption { type = lib.types.int; };
                                y = lib.mkOption { type = lib.types.int; };
                              };
                            }
                          );
                          default = {
                            x = 0;
                            y = 0;
                          };
                        };
                      };
                    }
                  );
                  default = [ ];
                  example = [
                    {
                      name = "HDMI-A-1";
                      rotation = 90;
                    }
                  ];
                };
                touchpad = lib.mkOption {
                  type = lib.types.bool;
                  description = "Should libinput be enabled?";
                  default = false;
                };
                fingerprint = lib.mkOption {
                  description = "Enabling fingerprint as well as driver";
                  type = lib.types.submodule {
                    options = {
                      enable = lib.mkOption {
                        type = lib.types.bool;
                        description = "Enable fingerprint?";
                      };
                      driver = lib.mkOption {
                        type = lib.types.package;
                        description = "Driver used for fingerprint";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
