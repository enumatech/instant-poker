{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  mppay = import ./default.nix { };
  # pythonEnv = mppay.passthru.python.withPackages: (ps: [ ps.ipython ]);

in mkShell {

  propagatedBuildInputs = mppay.propagatedBuildInputs ++ [
    python2Packages.ipython
    python2Packages.pylint
    python2Packages.flake8
  ];
  # buildInputs = [ pythonEnv ];

}
