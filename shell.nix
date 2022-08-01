{ pkgs ? import <nixpkgs> {} }:

let
  pythonWithPackages = pkgs.python3.withPackages (p: with p; [
    pip
    setuptools
    # Some dependencies using native code
    grpcio
    grpcio-tools
    # Utilities
    mnemonic
  ]);
in
pkgs.mkShell {
  buildInputs = [
    pythonWithPackages
  ];

  shellHook = ''
    # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
    # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
    export PIP_PREFIX=$(pwd)/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:${pythonWithPackages}/${pythonWithPackages.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
    unset SOURCE_DATE_EPOCH
  '';
}
