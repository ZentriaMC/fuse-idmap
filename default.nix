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

  buildInputs =
    lib.optional stdenv.isLinux fuse ++
    lib.optional stdenv.isDarwin macfuse-stubs;

  dontConfigure = true;
  makeFlags = [ "PREFIX=$(out)" ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace "-losxfuse" "-lfuse"
  '';

  preInstall = ''
    mkdir -p $out/lib
  '';
}
