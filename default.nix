{ mkDerivation, base, hspec, stdenv }:
mkDerivation {
  pname = "acme-omitted";
  version = "3.0.0.0";
  src = ./.;
  libraryHaskellDepends = [ base ];
  testHaskellDepends = [ base hspec ];
  homepage = "https://github.com/joachifm/acme-omitted#readme";
  description = "A name for omitted definitions";
  license = stdenv.lib.licenses.bsd3;
}
