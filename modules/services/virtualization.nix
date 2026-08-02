{
  flake.modules.nixos.virtualisation = {
    virtualisation.docker.enable = true;
    virtualisation.waydroid.enable = true;
    virtualisation.docker.daemon.settings = {
      data-root = "/home/hmp/.local/share/docker-root";
    };
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

}
