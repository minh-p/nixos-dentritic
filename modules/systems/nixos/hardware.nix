{ lib, self, ... }: {
  flake.modules.nixos.hardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    let
    in
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        self.modules.nixos.firmware
      ];
      config = lib.mkMerge [
        {
          boot.initrd.availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usbhid"
          ];
          boot.initrd.kernelModules = [ ];
          boot.kernelModules = [
            "uinput"
          ]
          ++ lib.optionals (config.myHost.vendors.cpu == "amd") [ "kvm-amd" ]
          ++ lib.optionals (config.myHost.vendors.cpu == "intel") [ "kvm-intel" ]
          ++ lib.optionals (config.myHost.vendors.gpu == "amd") [ ]
          ++ lib.optionals (config.myHost.vendors.gpu == "nvidia") [ ]
          ++ config.myHost.extraBootKernModules;
          boot.extraModulePackages = [ ];
        }
        (lib.mkIf (config.myHost.vendors.cpu == "amd") {
          hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        })
        (lib.mkIf (config.myHost.peripherals.touchpad == true) {
          services.libinput.enable = true;
        })
        (lib.mkIf (config.myHost.peripherals.fingerprint.enable == true) {
          services.fprintd.enable = true;
          services.fprintd.tod.enable = true;
          services.fprintd.tod.driver = config.myHost.peripherals.fingerprint.driver;
        })
      ];
    };
}
