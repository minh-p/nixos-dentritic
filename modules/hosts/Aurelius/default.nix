{ inputs, ... }: {
  flake.modules.nixos.Aurelius = { pkgs, ... }: {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
    time.timeZone = "America/Los_Angeles";

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
      hardware
      fileSystems
      grub
      silentboot
      networking
      fingerprint
      nix

      fcitx5
      thunar
      gpu-screen-recorder
    ];
  };

  flake.nixosConfigurations.Aurelius = inputs.nixpkgs.lib.nixosSystem {
    modules = [ inputs.self.modules.nixos.Aurelius ];
  };
}
