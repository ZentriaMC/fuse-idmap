{ lib
, stdenv
, rev
, fuse
, macfuse-stubs
}:

stdenv.mkDerivation {
  pname = "fuse-idmap";
  version = rev;

  src = ./.;

  buildInputs = [
  ] ++ lib.optionals stdenv.isLinux [
    fuse
  ] ++ lib.optionals stdenv.isDarwin [
    macfuse-stubs
  ];

  dontConfigure = true;
  makeFlags = [ "PREFIX=$(out)" ];

  NIX_CFLAGS_COMPILE = lib.optionalString stdenv.isDarwin "-I${macfuse-stubs}/include";
  NIX_LDFLAGS = lib.optionalString stdenv.isDarwin "-L${macfuse-stubs}/lib";

  preInstall = ''
    mkdir -p $out/lib
  '';
}
