{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
let version = "3.251";
in stdenvNoCC.mkDerivation {
  inherit version;
  pname = "bedstead-nerd-font";

  src = fetchzip {
    url = "https://bjh21.me.uk/bedstead/bedstead-${version}.zip";
    hash = "sha256-tP4DVXaXvwMyGLhlzU7woeBlreD5UgTau3QQ/WlnjVo=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    for file in $src/*.otf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $file 2> /dev/null
    done;
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description =
      "Bedstead is a family of outline fonts based on the characters produced by the Mullard SAA5050 series of Teletext Character Generators.";
    homepage = "https://bjh21.me.uk/bedstead";
    license = licenses.cc0;
    platforms = platforms.unix;
  };
}
