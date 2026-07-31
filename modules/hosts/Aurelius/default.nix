{ inputs, ... }: {
  systems = [ "x86_64-linux" ];
  nixpkgsStable = "nixos-26.05";

  flake.modules.nixos.Aurelius = { pkgs, ... }: {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
    time.timeZone = "America/Los_Angeles";

    _module.args.pkgs-unstable =
      inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

    myHost = {
      name = "Aurelius";
      diskLabels = {
        root = "nixos";
        swap = "swap";
        home = "home";
        boot = "boot";
      };
      vendors = {
        cpu = "amd";
        gpu = "amd";
      };
      extraBootKernModules = [ "uinput" ];
      peripherals = {
        touchpad = false;
        fingerprint = {
          enable = false;
          driver = pkgs.libfprint-2-tod1-goodix-550a;
        };
      };
    };

    imports = with inputs.self.modules.nixos; [
      options
      nix-settings

      hardware
      fileSystems
      grub
      silentboot
      networking
      fingerprint

      fonts
      fcitx5
      thunar

      firefox
      nvim

      gpu-screen-recorder
    ];
  };

  flake.nixosConfigurations.Aurelius = inputs.nixpkgs.lib.nixosSystem {
    modules = [ inputs.self.modules.nixos.Aurelius ];
  };
}
