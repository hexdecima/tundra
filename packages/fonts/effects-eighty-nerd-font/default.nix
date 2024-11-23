{ format ? "ttf", stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
assert lib.assertMsg (format == "ttf" || format == "otf")
  "The option `format` must be 'ttf' or 'otf'.";

stdenvNoCC.mkDerivation {
  pname = "effects-eighty-nerd-font";
  version = "2017-08-06";

  src = fetchzip {
    url =
      "https://fontlibrary.org/assets/downloads/effects-eighty/3b1759f5caa1e5d5bb2e9cda6850f6b0/effects-eighty.zip";
    hash = "sha256-zkOjHgNSDq8Y/Yi49vbgF9DSHWDbpJ+5x9RiK7BCYtI=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;

  installPhase = let
    ttf = ''
      mkdir -p $out/share/fonts/truetype
      for file in $src/*.ttf; do
        nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $file 2> /dev/null
      done
    '';

    otf = ''
      mkdir -p $out/share/fonts/opentype
      for file in $src/*.otf; do
        nerd-font-patcher -c -q --out "$out"/share/fonts/opentype $file 2> /dev/null
      done
    '';
  in ''
    runHook preInstall
    ${if format == "ttf" then
      ttf
    else
      (if format == "otf" then
        otf
      else
        abort "`format` is invalid. This should never happen.")}
    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description = ''
      Effects Eighty is an homage to the dot-matrix printers of the 1980s. It is a very faithful reproduction of the output of one of that class of printers.
      The family includes normal, italic, bold, and bold italic versions. It supports the ASCII printable character set.
    '';
    homepage = "https://fontlibrary.org/en/font/effects-eighty";
    license = licenses.ofl;
    platforms = platforms.unix;
  };
}
