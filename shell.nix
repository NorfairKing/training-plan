{ pkgs ? import (import ./nixpkgs.nix) {}
, ...
}:
let
  build = import ./default.nix { inherit pkgs; };
in
pkgs.stdenv.mkDerivation rec {
  name = "nixops-shell";

  buildInputs = [
    build
    (import ./latexenv.nix { inherit pkgs; })
  ];

  shellHook = ''
    export TERM=xterm
    function devel () {
      ${pkgs.evince}/bin/evince training.pdf &
      ${pkgs.watchexec}/bin/watchexec --exts tex -- latexmk -f -pdf training.tex -interaction=nonstopmode
    }
  '';

}
