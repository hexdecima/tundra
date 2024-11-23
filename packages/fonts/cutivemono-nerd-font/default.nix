{ stdenvNoCC, fetchFromGitHub, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final:
  let rev = "4422d783b81be0fcec82ef3610eac94784d989c1";
  in {
    pname = "cutivemono-nerd-font";
    version = builtins.substring 0 6 rev;
    src = fetchFromGitHub {
      repo = "cutivemono";
      owner = "googlefonts";
      sha256 = "mfoO27cC0vOy8AplUC+kB2AHiemyCCRIuOHZunXWf4g=";
      inherit rev;
    };
    nativeBuildInputs = [ nerd-font-patcher ];
    buildPhase = ''
      mkdir -p $out/share/fonts/truetype
      nerd-font-patcher -c -q --out $out/share/fonts/truetype $src/fonts/ttf/CutiveMono-Regular.ttf 2> /dev/null
    '';
    meta = let inherit (lib) licenses platforms;
    in {
      homepage = "https://github.com/googlefonts/cutivemono";
      license = licenses.ofl;
      platforms = platforms.linux;
    };
  })
