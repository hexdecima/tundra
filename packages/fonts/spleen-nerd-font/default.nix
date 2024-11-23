{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "spleen-nerd-font";
  version = "2.1.0";

  src = fetchzip {
    url =
      "https://github.com/fcambus/spleen/releases/download/${version}/spleen-${version}.tar.gz";
    hash = "sha256-wDD9yi7hQoFXtlh7okLX20FQRQWXOoivvnTobLJG0Pc=";
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
    description = "Monospaced bitmap fonts (Nerd Font patched, .otf only)";
    homepage = "https://github.com/fcambus/spleen";
    license = licenses.bsd2;
    platforms = platforms.linux;
  };
}
