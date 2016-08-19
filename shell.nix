with import <nixpkgs>{};

let
  hsEnv = haskellPackages.ghcWithPackages (hask: with hask; [
    cabal-install
    (hask.callPackage ./default.nix {})
  ]);
in

stdenv.mkDerivation rec {
  name = "acme-omitted-shell";
  src = if lib.inNixShell then null else ./.;

  buildInputs =
    [ cabal2nix
      hsEnv
    ];
}
