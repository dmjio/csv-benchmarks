{ pkgs ? import <nixpkgs> {} }:
let
  scythe-src = pkgs.fetchFromGitHub {
    owner = "dmjio";
    repo = "scythe";
    sha256 = "05jvxjw9z7r72v5yxbkrhxamnw6zshxn3kc3d6nixnshf32qlhhd";
    rev = "157a1ae4e73412e39f33e23685dff0408cb501a9";
  };
  overrides = self: super: with pkgs.haskell.lib; {
    hw-dsv = doJailbreak super.hw-dsv;
    scythe = self.callCabal2nix "scythe" scythe-src {};
  };
  hpkgs = pkgs.haskellPackages.override { inherit overrides; };
  csv-killa = hpkgs.callPackage ./csv-killa.nix {};
  benchmarks = pkgs.writeScriptBin "benchmarks" ''
    curl -O https://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/pad18c.zip
    unzip *.zip
    echo "Running cassava..."
    ${csv-killa}/bin/cassava +RTS -s
    echo "Running scythe..."
    ${csv-killa}/bin/scythe +RTS -s
    echo "Running hw-dsv..."
    ${csv-killa}/bin/hw-dsv +RTS -s
    echo "Running hw-dsv with BMI2 enabled..."
    ${csv-killa}/bin/hw-dsv-bmi2 +RTS -s
    echo "Running csv-killa..."
    ${csv-killa}/bin/csv-killa +RTS -s
  '';
in
  { inherit benchmarks csv-killa; }
