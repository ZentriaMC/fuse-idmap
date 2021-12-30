{ lib
, stdenv
, rev
, fuse
, osxfuse
}:

stdenv.mkDerivation {
  pname = "fuse-idmap";
  version = rev;

  src = ./.;

  buildInputs = [
  ] ++ lib.optionals stdenv.isLinux [
    fuse
  ] ++ lib.optionals stdenv.isDarwin [
    osxfuse
  ];

  dontConfigure = true;
  makeFlags = [ "PREFIX=$(out)" ];

  preInstall = ''
    mkdir -p $out/lib
  '';
}
