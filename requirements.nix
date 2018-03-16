# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 2.7 -E automake -E pkgconfig -E libtool -E libffi -E gmp -E openssl -E autoconf -E secp256k1 -r requirements.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python27Full;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ automake pkgconfig libtool libffi gmp openssl autoconf secp256k1 ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python27Full-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python2
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };



    "argh" = python.mkDerivation {
      name = "argh-0.26.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e3/75/1183b5d1663a66aebb2c184e0398724b624cecd4f4b679cb6e25de97ed15/argh-0.26.2.tar.gz"; sha256 = "e9535b8c84dc9571a48999094fda7f33e63c3f1b74f3e5f3ac0105a58405bb65"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/neithere/argh/";
        license = licenses.lgpl2;
        description = "An unobtrusive argparse wrapper with natural syntax";
      };
    };



    "attrs" = python.mkDerivation {
      name = "attrs-17.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8b/0b/a06cfcb69d0cb004fde8bc6f0fd192d96d565d1b8aa2829f0f20adb796e5/attrs-17.4.0.tar.gz"; sha256 = "1c7960ccfd6a005cd9f7ba884e6316b5e430a3f1a6c37c5f87d8b43f83b54ec9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };



    "bitcoin" = python.mkDerivation {
      name = "bitcoin-1.1.42";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/12/88/c9390638d5b2713d38ccea46c93e8ec084f052a15a94f9b1d4c66baabd24/bitcoin-1.1.42.tar.gz"; sha256 = "11ba70bd9e1c764f6bb2c4bd4c7fbebd5c9053c73f4d4325b00a98869a8b7236"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/vbuterin/pybitcointools";
        license = "";
        description = "Python Bitcoin Tools";
      };
    };



    "cffi" = python.mkDerivation {
      name = "cffi-1.11.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/10/f7/3b302ff34045f25065091d40e074479d6893882faef135c96f181a57ed06/cffi-1.11.4.tar.gz"; sha256 = "df9083a992b17a28cd4251a3f5c879e0198bb26c9e808c4647e0a18739f1d11d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pycparser"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };



    "colorama" = python.mkDerivation {
      name = "colorama-0.3.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e6/76/257b53926889e2835355d74fec73d82662100135293e17d382e2b74d1669/colorama-0.3.9.tar.gz"; sha256 = "48eb22f4f8461b1df5734a074b57042430fb06e1d61bd1e11b078c0fe6d7a1f1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tartley/colorama";
        license = licenses.bsdOriginal;
        description = "Cross-platform colored terminal text.";
      };
    };



    "coverage" = python.mkDerivation {
      name = "coverage-4.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/35/fe/e7df7289d717426093c68d156e0fd9117c8f4872b6588e8a8928a0f68424/coverage-4.5.1.tar.gz"; sha256 = "56e448f051a201c5ebbaa86a5efd0ca90d327204d8b059ab25ad0f35fbfd79f1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/ned/coveragepy";
        license = licenses.asl20;
        description = "Code coverage measurement for Python";
      };
    };



    "docopt" = python.mkDerivation {
      name = "docopt-0.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"; sha256 = "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docopt.org";
        license = licenses.mit;
        description = "Pythonic argument parser, that will make you smile";
      };
    };



    "ethereum" = python.mkDerivation {
      name = "ethereum-1.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8d/d2/f20638de4c3ab6a28a64c079a7e20cede57491d872c6ce62b2e6839adfe6/ethereum-1.6.1.tar.gz"; sha256 = "2c3baa6ff41398088c9d35541c551f194eadc57dc70d56068af3381780fe234d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."bitcoin"
      self."pbkdf2"
      self."pycryptodome"
      self."pyethash"
      self."pysha3"
      self."repoze.lru"
      self."rlp"
      self."scrypt"
      self."secp256k1"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ethereum/pyethereum/";
        license = "";
        description = "Next generation cryptocurrency network";
      };
    };



    "funcsigs" = python.mkDerivation {
      name = "funcsigs-1.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23/funcsigs-1.0.2.tar.gz"; sha256 = "a7bb0f2cf3a3fd1ab2732cb49eba4252c2af4240442415b4abce3b87022a8f50"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://funcsigs.readthedocs.org";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Python function signatures from PEP362 for Python 2.6, 2.7 and 3.2+";
      };
    };



    "pathtools" = python.mkDerivation {
      name = "pathtools-0.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e7/7f/470d6fcdf23f9f3518f6b0b76be9df16dcc8630ad409947f8be2eb0ed13a/pathtools-0.1.2.tar.gz"; sha256 = "7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gorakhargosh/pathtools";
        license = licenses.mit;
        description = "File system general utilities";
      };
    };



    "pbkdf2" = python.mkDerivation {
      name = "pbkdf2-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/02/c0/6a2376ae81beb82eda645a091684c0b0becb86b972def7849ea9066e3d5e/pbkdf2-1.3.tar.gz"; sha256 = "ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.dlitz.net/software/python-pbkdf2/";
        license = licenses.mit;
        description = "PKCS#5 v2.0 PBKDF2 Module";
      };
    };



    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz"; sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };



    "py" = python.mkDerivation {
      name = "py-1.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/e3/e075127d39d35f09a500ebb4a90afd10f9ef0a1d28a6d09abeec0e444fdd/py-1.5.2.tar.gz"; sha256 = "ca18943e28235417756316bfada6cd96b23ce60dd532642690dcfdaba988a76d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };



    "pycparser" = python.mkDerivation {
      name = "pycparser-2.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"; sha256 = "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };



    "pycryptodome" = python.mkDerivation {
      name = "pycryptodome-3.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/d1/f1c6b1e4b2dd5e3f2f56f6f3c74ac9893252dbef9ac0e55c8b4538e56db0/pycryptodome-3.5.1.tar.gz"; sha256 = "b7957736f5e868416b06ff033f8525e64630c99a8880b531836605190b0cac96"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.pycryptodome.org";
        license = licenses.bsdOriginal;
        description = "Cryptographic library for Python";
      };
    };



    "pyethash" = python.mkDerivation {
      name = "pyethash-0.1.27";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6c/40/5bb02ad7e2fae9b04cd0c391dda81213bc786c30c8381b018600cfc7ce62/pyethash-0.1.27.tar.gz"; sha256 = "ff66319ce26b9d77df1f610942634dac9742e216f2c27b051c0a2c2dec9c2818"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ethereum/ethash";
        license = licenses.mit;
        description = "Python wrappers for ethash, the ethereum proof of workhashing function";
      };
    };



    "pysha3" = python.mkDerivation {
      name = "pysha3-1.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/73/bf/978d424ac6c9076d73b8fdc8ab8ad46f98af0c34669d736b1d83c758afee/pysha3-1.0.2.tar.gz"; sha256 = "fe988e73f2ce6d947220624f04d467faf05f1bbdbc64b0a201296bb3af92739e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tiran/pysha3";
        license = licenses.psfl;
        description = "SHA-3 (Keccak) for Python 2.7 - 3.5";
      };
    };



    "pytest" = python.mkDerivation {
      name = "pytest-3.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/dd/05/4579d3028ba1740467690c3427d3991eff91f95cbaa6bb0280f40708721a/pytest-3.4.2.tar.gz"; sha256 = "117bad36c1a787e1a8a659df35de53ba05f9f3398fb9e4ac17e80ad5903eb8c5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
      self."colorama"
      self."funcsigs"
      self."pluggy"
      self."py"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest.org";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };



    "pytest-cov" = python.mkDerivation {
      name = "pytest-cov-2.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz"; sha256 = "03aa752cf11db41d281ea1d807d954c4eda35cfa1b21d6971966cc041bbf6e2d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-cov";
        license = licenses.bsdOriginal;
        description = "Pytest plugin for measuring coverage.";
      };
    };



    "pytest-watch" = python.mkDerivation {
      name = "pytest-watch-4.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e9/88/69b94fe4cb3d3b106b184056bc80ade6b0a9062e5a9a1cb65aec58831281/pytest-watch-4.1.0.zip"; sha256 = "29941f6ff74e6d85cc0796434a5cbc27ebe51e91ed24fd0757fad5cc6fd3d491"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."colorama"
      self."docopt"
      self."pytest"
      self."watchdog"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/joeyespo/pytest-watch";
        license = licenses.mit;
        description = "Local continuous test runner with pytest and watchdog.";
      };
    };



    "repoze.lru" = python.mkDerivation {
      name = "repoze.lru-0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz"; sha256 = "0429a75e19380e4ed50c0694e26ac8819b4ea7851ee1fc7583c8572db80aff77"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "License :: Repoze Public License";
        description = "A tiny LRU cache implementation and decorator";
      };
    };



    "rlp" = python.mkDerivation {
      name = "rlp-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f9/53/922c7a15116e52cd7340f81b83322d5ec9d38668cd78d1a0c7e75dfce8f2/rlp-0.6.0.tar.gz"; sha256 = "87879a0ba1479b760cee98af165de2eee95258b261faa293199f60742be96f34"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ethereum/pyrlp";
        license = licenses.bsdOriginal;
        description = "A package for encoding and decoding data in and from Recursive Length Prefix notation";
      };
    };



    "scrypt" = python.mkDerivation {
      name = "scrypt-0.8.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/6f/3c8dd0f18f73ceddfbdd606c0c895ebb66748606682d77da3743c7c0c56f/scrypt-0.8.6.tar.gz"; sha256 = "f8239b2d47fa1d40bc27efd231dc7083695d10c1c2ac51a99380360741e0362d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/mhallin/py-scrypt";
        license = licenses.bsdOriginal;
        description = "Bindings for the scrypt key derivation function library";
      };
    };



    "secp256k1" = python.mkDerivation {
      name = "secp256k1-0.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/52/62/d7bf3829e126e517e253d2e22a63511c54bbaac34d7ddea316cde040fc49/secp256k1-0.13.2.tar.gz"; sha256 = "a3b43e02d321c09eafa769a6fc2c156f555cab3a7db62175ef2fd21e16cdf20c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cffi"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ludbb/secp256k1-py";
        license = licenses.mit;
        description = "FFI bindings to libsecp256k1";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "watchdog" = python.mkDerivation {
      name = "watchdog-0.8.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/7d/c7c0ad1e32b9f132075967fc353a244eb2b375a3d2f5b0ce612fd96e107e/watchdog-0.8.3.tar.gz"; sha256 = "7e65882adb7746039b6f3876ee174952f8eaaa34491ba34333ddf1fe35de4162"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."argh"
      self."pathtools"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gorakhargosh/watchdog";
        license = licenses.asl20;
        description = "Filesystem events monitoring";
      };
    };

  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [

  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )