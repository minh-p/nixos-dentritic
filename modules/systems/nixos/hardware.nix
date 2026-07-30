{ lib, inputs, ... }: {
  flake.modules.nixos.hardware =
    { config, modulesPath, vendors, moreKernMods, ... }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.self.modules.nixos.firmware
      ];
      boot.initrd.availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "uinput" ]
        ++ lib.optionals (vendors.cpu == "amd") [ "kvm-amd" ]
        ++ lib.optionals (vendors.cpu == "intel") [ "kvm-intel" ]
        ++ lib.optionals (vendors.gpu == "amd") [ ]
        ++ lib.optionals (vendors.gpu == "nvidia") [ ] ++ moreKernMods;
      boot.extraModulePackages = [ ];
    } // lib.mkIf (vendors.cpu == "amd") {
      hardware.cpu.amd.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
