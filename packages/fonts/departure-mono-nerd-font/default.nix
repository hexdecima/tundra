{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "departure-mono-nerd-font";
  version = "1.346";

  src = fetchzip {
    url = "https://departuremono.com/assets/DepartureMono-${final.version}.zip";
    hash = "sha256-xJVVtLnukcWQKVC3QiHvrfIA3W9EYt/iiphbLYT1iMg=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    for file in $src/*.otf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $file 2> /dev/null;
    done;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description =
      "Departure Mono is a monospaced pixel font with a lo-fi technical vibe (Nerd Font patched, .otf only)";
    homepage = "https://departuremono.com";
    license = licenses.ofl;
    platforms = platforms.unix;
  };
})
