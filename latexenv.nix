{ pkgs ? import (import ./nixpkgs.nix) {}
, ...
}:
with pkgs;
texlive.combine {
  inherit
      (texlive)
      scheme-full
      latexmk
      libertine
    ;
}
