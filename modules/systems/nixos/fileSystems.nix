{
  flake.modules.nixos.fileSystems = { config, ... }: {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/${config.myHost.diskLabels.root}";
        fsType = "ext4";
      };

      "/home" = {
        device = "/dev/disk/by-label/${config.myHost.diskLabels.home}";
        fsType = "ext4";
      };

      "/boot/EFI" = {
        device = "/dev/disk/by-label/${config.myHost.diskLabels.boot}";
        fsType = "vfat";
      };
    };

    swapDevices = [ { device = "/dev/disk/by-label/${config.myHost.diskLabels.swap}"; } ];
  };
}
