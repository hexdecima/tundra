{ stdenv, fetchurl, nerd-font-patcher, ... }:
let version = "3.1.9";
in stdenv.mkDerivation {
  inherit version;
  pname = "zpix-nerd-font";
  src = fetchurl {
    url =
      "https://github.com/SolidZORO/zpix-pixel-font/releases/download/v${version}/zpix.ttf";
    sha256 = "2Kgw4Zqs/pibfQ3kXwUGV+g7GEDMurD4YApTUtus+eM=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/fonts/truetype"
    nerd-font-patcher -c -q --out "$out/share/fonts/truetype" "$src"

    runHook postInstall
  '';
}
