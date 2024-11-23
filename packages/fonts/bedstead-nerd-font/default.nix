{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "bedstead-nerd-font";
  version = "002.006";

  src = fetchzip {
    url = "https://bjh21.me.uk/bedstead/bedstead-${version}.zip";
    hash = "sha256-N2EgkJb0AAcDL0K1XSliBYuOcjJkXgy+zZeb5PTG1Kw=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    for file in $src/*.otf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $file 2> /dev/null
    done;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description =
      "Bedstead is a family of outline fonts based on the characters produced by the Mullard SAA5050 series of Teletext Character Generators.";
    homepage = "https://bjh21.me.uk/bedstead/";
    license = licenses.cc0; # according to COPYING file.
    platforms = platforms.unix;
  };
}
