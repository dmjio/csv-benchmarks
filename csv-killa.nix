{ mkDerivation, base, bytestring, cassava, hw-dsv, scythe, stdenv
, vector
}:
mkDerivation {
  pname = "csv-killa";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring cassava hw-dsv scythe vector
  ];
  description = "csv killin'";
  license = stdenv.lib.licenses.bsd3;
}
