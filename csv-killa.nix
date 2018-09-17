{ mkDerivation, base, bytestring, stdenv }:
mkDerivation {
  pname = "csv-killa";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base bytestring ];
  description = "csv killin'";
  license = stdenv.lib.licenses.bsd3;
}
