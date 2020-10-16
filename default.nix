{ pkgs ? import (import ./nixpkgs.nix) {}
, ...
}:

with pkgs;

let
  gitignoreSrc = pkgs.fetchFromGitHub {
    owner = "hercules-ci";
    repo = "gitignore";
    # put the latest commit sha of gitignore Nix library here:
    rev = "7415c4feb127845553943a3856cbc5cb967ee5e0";
    # use what nix suggests in the mismatch message here:
    sha256 = "sha256:1zd1ylgkndbb5szji32ivfhwh04mr1sbgrnvbrqpmfb67g2g3r9i";
  };
  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;

in

stdenv.mkDerivation {
  name = "training";
  buildInputs = [
    (import ./latexenv.nix { inherit pkgs; })
  ];
  src = gitignoreSource ./.;
  phases = "unpackPhase buildPhase";
  buildPhase = ''
    latexmk -pdf training.tex
    mkdir -p $out
    cp -r training.pdf $out/training.pdf
  '';
}
