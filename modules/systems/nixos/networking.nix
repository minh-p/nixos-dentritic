{
  flake.modules.nixos.networking = { hostName, pkgs, ... }: {
    networking.hostName = hostName;
    networking.useDHCP = false;
    networking.interfaces.enp0s3.useDHCP = true;
    networking.networkmanager.enable = true;

    networking.networkmanager.plugins = [ pkgs.networkmanager-openconnect ];
    networking.wireless.iwd.enable = true;
    networking.networkmanager.wifi.backend = "iwd";

    networking.wireless.iwd.settings = {
      IPv6 = { Enabled = true; };
      Settings = { AutoConnect = true; };
    };

  };
}
