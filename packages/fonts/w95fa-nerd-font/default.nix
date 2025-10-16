{ stdenvNoCC, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "w95fa-nerd-font";
  version = "1.0";

  src = ./W95FA.otf;
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype

    nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $src 2> /dev/null;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    homepage = "https://fontsarena.com/w95fa-by-alina-sava/";
    license = licenses.ofl;
    platforms = platforms.unix;
  };
})
