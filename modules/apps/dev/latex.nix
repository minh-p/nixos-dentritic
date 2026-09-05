{
  flake.modules.homeManager.latex = { pkgs, ... }: {
    home.packages = [
      (pkgs.texliveBasic.withPackages (
        ps: with ps; [
          dvisvgm
          dvipng

          amsmath
          ulem
          hyperref
          wrapfig
          capt-of
        ]
      ))
    ];
  };
}
