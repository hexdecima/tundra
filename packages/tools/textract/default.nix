# TODO: unfinished. need to tweak gradle options and probably downgrade gradle to 2.x (which is in nixpkgs <19.09).
# the `-bin` version is enough for now.
{ stdenv, fetchFromGitHub, jre, gradle_7, makeWrapper, stripJavaArchivesHook
, lib, ... }:
stdenv.mkDerivation {
  pname = "textract";
  version = "git+09-06-2020";
  src = fetchFromGitHub {
    owner = "antag99";
    repo = "TExtract";
    rev = "d401df4";
    hash = "sha256-4dDlaz0lokRmCvhTpiG3JQLzFQEHmKJttDZvvT4/6yc=";
  };

  nativeBuildInputs = [ gradle_7 makeWrapper stripJavaArchivesHook ];
  gradleFlags = [ "jvmargs=-Xms128m -Xmx512m" ];
  gradleBuildTask = "jar";
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share

    cp $src/lib/* $out/share
    makeWrapper ${lib.getExe jre} $out/bin/textract \
      --add-flags "-jar $out/share/TExtract.jar"
  '';
  meta = { broken = true; };
}
