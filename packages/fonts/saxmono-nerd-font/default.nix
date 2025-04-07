{ stdenvNoCC, fetchurl, unzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation {
  pname = "saxmono-nerd-font";
  version = "16-01-2009";

  src = fetchurl {
    url = "https://www.fontsquirrel.com/fonts/download/saxMono";
    hash = "sha256-vur3woVBq1b8vhB06bGLMn2xkkpwi4xdH5Oi3mxO0S0=";
  };
  nativeBuildInputs = [ nerd-font-patcher unzip ];
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype $out/tmp
    unzip -d $out/tmp $src
    nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $out/tmp/saxmono.ttf
    rm -rf $out/tmp

    runHook postInstall
  '';

  meta = {
    description =
      "saxMono is a sample of a fine TrueType with high screen quality. Its spacing (11 cpi@12 pt) is between the Courier and Letter Gothic.";
    homepage = "https://www.fontsquirrel.com/fonts/saxMono";
    license = {
      fullName = "s.a.x. Software License";
      url = "https://www.fontsquirrel.com/license/saxMono";
      free = true;
    };
    platforms = lib.platforms.unix;
  };
}
