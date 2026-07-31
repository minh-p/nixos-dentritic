{
  flake.modules.nixos.networking = { config, pkgs, ... }: {
    networking.hostName = config.myHost.name;
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
