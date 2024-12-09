{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "monofoki-nerd-font";
  version = "3.1";

  src = fetchzip {
    url =
      "https://github.com/datMaffin/monofoki/releases/download/${final.version}/export.zip";
    hash = "sha256-kE8yqZbfsfKhN0Mbu1/rVXWYpTZ5C+ezPRrhCIH7JEM=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    for file in $src/*.ttf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $file 2> /dev/null;
    done;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description = "Fork of Mononoki. (Nerd Font patched)";
    homepage = "https://github.com/datMaffin/monofoki";
    license = licenses.ofl;
    platforms = platforms.unix;
  };
})
