{
  flake.modules.nixos.grub = {
    boot = {
      plymouth.enable = true;
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/EFI";
        };
        grub = {
          enable = true;
          useOSProber = true;
          copyKernels = true;
          efiSupport = true;
          fsIdentifier = "label";
          #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
          device = "nodev";
          extraEntries = ''
            menuentry "Reboot" {
                reboot
            }
            menuentry "Poweroff" {
                halt
            }
          '';
        };
      };
    };
  };
}
