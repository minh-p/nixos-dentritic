{ inputs, ... }: {
  flake.modules.nixos.Aurelius = {
    system.stateVersion = "26.11";
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
