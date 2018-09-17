{ pkgs ? import <nixpkgs> {} }:
  pkgs.haskellPackages.callPackage ./csv-killa.nix {}
