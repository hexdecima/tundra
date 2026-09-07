{ lib, stdenvNoCC, fetchzip, nerd-font-patcher, coreutils, ... }:
let version = "2.000";
in stdenvNoCC.mkDerivation rec {
  inherit version;
  pname = "oxanium-nerd-font";
  src = fetchzip {
    url =
      "https://github.com/sevmeyer/oxanium/releases/download/${version}/oxanium-${version}.zip";
    hash = "sha256-AXhz6EQuDAYAU8CwttPRdREf11FNX1d6csfUGqcxSEI=";
    stripRoot = false;
  };
  nativeBuildInputs = [ nerd-font-patcher coreutils ];

  buildPhase = let
    outDir = "${builtins.placeholder "out"}/share/fonts/truetype";
    mkdir = lib.getExe' coreutils "mkdir";
  in ''
    ${mkdir} -p ${outDir}
    for FILE in ${src}/fonts/ttf/*.ttf; do
      ${lib.getExe nerd-font-patcher} -c -q --out ${outDir} $FILE 2> /dev/null
    done
  '';
  meta = let inherit (lib) licenses; in {
    homepage = "https://github.com/sevmeyer/oxanium";
    license = licenses.ofl;
  };
}
