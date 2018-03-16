### Development

Install nix package manager for your platform

```
nix-shell
```

You can now run the python scripts.

The `requirements.nix` is generated with the command
```
pypi2nix -V 2.7 -E automake -E pkgconfig -E libtool -E libffi -E gmp \
                -E openssl -E autoconf -E secp256k1 -r requirements.txt
```
where pypy2nix is from https://github.com/garbas/pypi2nix and can be installed
via
```
git clone https://github.com/garbas/pypi2nix
cd pypi2nix
nix-env -f release.nix -iA build."x86_64-linux"
```
