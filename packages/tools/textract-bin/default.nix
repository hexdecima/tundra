# NOTE: GUI won't run under Wayland, use either xwayland or, more conveniently, the CLI.
{ stdenvNoCC, fetchurl, makeWrapper, jre, lib, ... }:
stdenvNoCC.mkDerivation {
  pname = "textract-bin";
  version = "1.7.0";
  src = fetchurl {
    url = "https://www.dropbox.com/s/81ytwly8mb1ziko/TExtract%201.7.0.jar?dl=1";
    hash = "sha256-WHFmUHWDuA/aCZs748VBMKVSDN8+Pfzgjm0KQDxBZc0=";
  };
  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp $src $out/share/TExtract.jar

    makeWrapper ${lib.getExe jre} $out/bin/textract \
      --add-flags "-jar $out/share/TExtract.jar"
  '';
  meta = {
    mainProgram = "textract";
    homepage = "https://github.com/antag99/TExtract";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
  };
}
