{
  flake.modules.nixos.fcitx5 = { pkgs, ... }: {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        qt6Packages.fcitx5-qt
        qt6Packages.fcitx5-configtool
        qt6Packages.fcitx5-unikey
      ];
    };
  };
}
