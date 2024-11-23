{ stdenvNoCC, fetchzip, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "scientifica-nerd-font";
  version = "2.3";

  src = fetchzip {
    url =
      "https://github.com/nerdypepper/scientifica/releases/download/v${final.version}/scientifica.tar";
    sha256 = "sha256-1+dL7wQp+y3U/PDMJQaYeRzvOoNWgHoeja4E9AMccnM=";
  };
  nativeBuildInputs = [ nerd-font-patcher ];
  buildPhase = ''
    mkdir -p $out/share/fonts/truetype
    for file in $src/ttf/*.ttf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $file;
    done;
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    description = "tall, condensed, bitmap font for geeks. (Nerd Font patched)";
    homepage = "https://github.com/nerdypepper/scientifica";
    license = licenses.ofl;
    platforms = platforms.linux;
  };
})
