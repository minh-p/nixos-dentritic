{ lib, ... }: {
  flake.modules.nixos.hardware = { modulesPath, vendors, moreKernMods, ... }: {
    nixpkgs.hostPlatform = "x86_64-linux";
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "uinput" ]
      ++ lib.optionals (vendors.cpu == "amd") [ "kvm-amd" ]
      ++ lib.optionals (vendors.cpu == "intel") [ "kvm-intel" ]
      ++ lib.optionals (vendors.gpu == "amd") [ ]
      ++ lib.optionals (vendors.gpu == "nvidia") [ ] ++ moreKernMods;
    boot.extraModulePackages = [ ];
  };
}
