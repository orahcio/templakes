{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      custompypackage = pkgs.python311Packages.buildPythonPackage rec {
        propagatedBuildInputs = with pkgs.python311Packages;[
          # dependencias
        ];
        pname = "nome_no_pip";
        version = "x.x.x";
        format = "wheel";
        url = "";
        src = pkgs.python311Packages.fetchPypi {
          inherit pname version;
          sha256 = "";
        };
      };
    in {
      devShell = pkgs.mkShell rec {
        # venvDir = "./.venv";
        buildInputs = with pkgs.python311Packages; [
          # venvShellHook
          ipykernel
          notebook
          pip
          #poetry
          # pkgs.stdenv.cc.cc
          # pkgs.zlib
          #lib
          #libGL
          #libGLU
          #xorg.libX11
        ];
        # Esse approuch permite que eu instale pacotes que estão quebrados no nixos pelo pip
        # shellHook = ''  
        #   # for PyTorch
        #   export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
          
        #   # Dir where built packages are stored
        #   export PIP_PREFIX=$(pwd)/_build/pip_packages
        #   export PYTHONPATH="$PIP_PREFIX/${pkgs.python311.sitePackages}:$PYTHONPATH"
        #   export PATH="$PIP_PREFIX/bin:$PATH"
          
        #   # for Numpy
        #   export LD_LIBRARY_PATH=${pkgs.zlib}/lib:$LD_LIBRARY_PATH

        #   # export LD_LIBRARY_PATH=${pkgs.glibc}/lib:$LD_LIBRARY_PATH

        #   export LD_LIBRARY_PATH=${pkgs.zlib}/lib:$LD_LIBRARY_PATH
        #   #   # GL libraries (for gym environment rendering)
        #   #   export LD_LIBRARY_PATH=${pkgs.libGL}/lib:$LD_LIBRARY_PATH
        #   #   export LD_LIBRARY_PATH=${pkgs.libGLU}/lib:$LD_LIBRARY_PATH

        #   unset SOURCE_DATE_EPOCH
        #   # source .venv/bin/activate
        # '';
      };
    });
}
