{ inputs, ... }: {
  flake.modules.nixos.Aurelius = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
    _module.args = {
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
      moreKernMods = [ "uinput" ];
    };
    imports = with inputs.self.modules.nixos; [
      hardware
      fileSystems
      grub
      silentboot
    ];
  };

  flake.nixosConfigurations.Aurelius = inputs.nixpkgs.lib.nixosSystem {
    modules = [ inputs.self.modules.nixos.Aurelius ];
  };
}
