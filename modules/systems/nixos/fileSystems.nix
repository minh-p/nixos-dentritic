{
  flake.modules.nixos.fileSystems = { diskLabels, ... }: {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/${diskLabels.root}";
        fsType = "ext4";
      };

      "/home" = {
        device = "/dev/disk/by-label/${diskLabels.home}";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-label/${diskLabels.boot}";
        fsType = "vfat";
      };
    };

    swapDevices = [{ device = "/dev/disk/by-label/${diskLabels.swap}"; }];
  };
}
