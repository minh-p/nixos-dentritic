{
  flake.modules.homeManager.library = { pkgs, ... }: {
    home.packages = [
      pkgs.calibre
      pkgs.sioyek
      pkgs.djvulibre
      pkgs.ocrmypdf
      pkgs.jbig2enc
      pkgs.pngquant
      pkgs.poppler-utils
    ];
  };
}
