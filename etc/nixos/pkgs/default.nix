# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  python3 = let 
    packageOverrides = self: super: {
        # make sure we build virualenv with the lastest platformdirs before overwritting it
        virtualenv = super.virtualenv.overridePythonAttrs(old: {
            buildInputs = (old.buildInputs or []) ++ [super.platformdirs];
            doCheck = false;
        });
        platformdirs = super.platformdirs.overridePythonAttrs(old: rec {
            version = "3.0.0";
            src = super.fetchPypi {
                pname = "platformdirs";
                inherit version;
                hash = "sha256-ihIoq7HvgteI90E5mIsTfnhpKYTsewjqpsZfFyOvKPk=";
            };
            doCheck = false;
        });
        charset-normalizer = super.charset-normalizer.overridePythonAttrs(old: rec {
            version = "3.1.0";
            src = super.fetchPypi {
                pname = "charset-normalizer";
                inherit version;
                hash = "sha256-NOCi+cNw65VZeq5jv4XrXpaCbYHj3PiLiIYBKQb1CbU=";
            };
            doCheck = false;
        });
        marshmallow = super.marshmallow.overridePythonAttrs(old: rec {
            version = "3.18.0";
            src = super.fetchPypi {
                pname = "marshmallow";
                inherit version;
                hash = "sha256-aATBYRT3/OH1tNrcMfRnSvIzF/zH8HXaIeNcGjXXgfc=";
            };
            build-system = [super.setuptools];
            doCheck = false;
        });
        marshmallow-dataclass = super.marshmallow-dataclass.overridePythonAttrs(old: rec {
            version = "8.5.9";
            format = "setuptools";
            buildInputs = (old.buildInputs or []) ++ [super.setuptools];
            src = pkgs.fetchFromGitHub {
                owner = "lovasoa";
                repo = "marshmallow_dataclass";
                rev = "refs/tags/v${version}";
                hash = "sha256-gA5GxE2as/P5yT3ymvXmLQfG2GyZE7Fj+zBaT88O4vY=";
            };
            doCheck = false;
        });
        pygitguardian = pkgs.python3.pkgs.pygitguardian.overridePythonAttrs(old: rec {
            version = "1.16.0";
            build-system = [super.pdm-backend];
            src = super.fetchPypi {
                pname = "pygitguardian";
                inherit version;
                hash = "sha256-kffFRU/PfTN5RvU8NdA15JeSJL9F66he2C+dOTnJBP0=";
            };
            # local_setuptools = pkgs.fetchFromGitHub {
            #     version = "72.1.0";
            #     owner = "pypa";
            #     repo = "setuptools";
            #     rev = "refs/tags/v${version}";
            #     hash = "sha256-LXF3R9zfWylvihP2M8N94/IlgifwxUwKJFhtvcXEPB0=";
            # };
            # dependencies = let setuptools = pkgs.fetchFromGitHub {
            #     version = "72.0.0";
            #     owner = "pypa";
            #     repo = "setuptools";
            #     rev = "refs/tags/v${version}";
            #     hash = "sha256-LXF3R9zfWylvihP2M8N94/IlgifwxUwKJFhtvcXEPB0=";
            # }; in (old.dependencies or []) ++ [ setuptools ];
            # dependencies = (old.dependencies or []) ++ [local_setuptools];
            # propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [local_setuptools];
            doCheck = false;
        });
        pyjwt = super.pyjwt.overridePythonAttrs(old: rec {
            version = "2.6.0";
            src = super.fetchPypi {
                pname = "PyJWT";
                inherit version;
                hash = "sha256-aShcfjH8RPaKH+swnpSODfUyWdV5KV5s/isXkjKfBf0=";
            };
            doCheck = false;
        });
        python-dotenv = super.python-dotenv.overridePythonAttrs(old: rec {
            version = "0.21.0";
            src = super.fetchPypi {
                pname = "python-dotenv";
                inherit version;
                hash = "sha256-t30IJ0Y549NBRd+mxwCOZt8PBLe+enX9DVKSwZHXkEU=";
            };
            doCheck = false;
        });
        requests = super.requests.overridePythonAttrs(old: rec {
            version = "2.32.0";
            src = super.fetchPypi {
                pname = "requests";
                inherit version;
                hash = "sha256-+lSQMZR0yC7x0sm8RZ02UuOuTvTE690YohFFpHyktrg=";
            };
            doCheck = false;
        });
        urllib3 = super.urllib3.overridePythonAttrs(old: rec {
            version = "2.2.2";
            src = super.fetchPypi {
                pname = "urllib3";
                inherit version;
                hash = "sha256-3VBUhVSaelUoM9peYGNjnQ0XfATyO8OGTkHl3F9hIWg=";
            };
            doCheck = false;
        });
        rich = super.rich.overridePythonAttrs(old: rec {
            version = "12.5.1";
            src = super.fetchPypi {
                pname = "rich";
                inherit version;
                hash = "sha256-Y6XFzjZz09X7vyPNh+EauEtrRRQ28bfxnsVLa8Nu18o=";
            };
            # there are no tests, enabling throws an error
            doCheck = false;
            buildInputs = [ super.commonmark ];
        });
    };
  in pkgs.python3.override {inherit packageOverrides; self = python3;};
in
{
  ggshield = pkgs.callPackage ./ggshield.nix { python3 = python3;};
}
