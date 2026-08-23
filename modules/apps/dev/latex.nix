{
  flake.modules.homeManager.latex = { pkgs, ... }: {
    home.packages = [
      (pkgs.texliveBasics.withPackages (
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
