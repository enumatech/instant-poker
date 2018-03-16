### This can help to cache the pkg tree but `fetchTarball` doesn't seem to support specifying a hash
# { pkgs ? import (builtins.fetchTarball
#  { url = "https://github.com/nixos/nixpkgs/archive/14068234465f16c0e635f5eb3822ce91d30559ab.tar.gz";
#     sha256 = "0i45mni9wgvn21n627hxbcnx95miifq7lnafi3cjdy0knxpg8c4l";}) {} }:
{ pkgs ? import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/14068234465f16c0e635f5eb3822ce91d30559ab.tar.gz") {} }:

let
  python = import ./requirements.nix { inherit pkgs; };

in python.mkDerivation {
  name = "Poker-0.1.0";
  src = ./.;
  buildInputs = [
  ];
  propagatedBuildInputs = [
    pkgs.solc
    python.packages."pytest"
    python.packages."pytest-cov"
    python.packages."pytest-watch"
    python.packages."bitcoin"
    python.packages."ethereum"
    pkgs.openssl
  ];
}
