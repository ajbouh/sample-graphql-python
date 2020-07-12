# Used https://discourse.nixos.org/t/how-to-create-a-nix-shell-environment-with-different-python-version-as-default/3236/3
let
in
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python38
    python38Packages.setuptools
    python38Packages.virtualenv
    python38Packages.poetry
    nodejs-12_x
    yarn
  ];


 shellHook =
   ''
     export SOURCE_DATE_EPOCH=$(date +%s)
     export PATH=$PWD/node_modules/.bin/:"$PATH"
   '';
}
