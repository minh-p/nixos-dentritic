{
  flake.modules.nixos.studying = { pkgs, ... }: {
    boot.kernelModules = [ "uinput" ];
    hardware.opentabletdriver.enable = true;
    environment.systemPackages = [
      pkgs.drawy
      pkgs.xournalpp
    ];
  };
}
