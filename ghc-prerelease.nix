# Specify the precise commit of GHC that we are going to use by default
{ version
, rev
, sha256
, nixpkgs
}:

let spec =
  {
    inherit version;
    src =
      nixpkgs.fetchFromGitHub {
        url = "https://github.com/ghc/ghc";
        inherit rev;
        inherit sha256;
      };
  };

in

(nixpkgs.haskell.compiler.ghcHEAD.override
    { version = spec.version
    ; bootPkgs = nixpkgs.haskell.packages.ghc843; }).overrideAttrs(oldAttrs:
    { src = spec.src; })

