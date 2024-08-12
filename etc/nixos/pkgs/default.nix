# default.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  python3 = let 
    packageOverrides = self: super: {
        platformdirs = super.platformdirs.overridePythonAttrs(old: rec {
            version = "3.9.1";
            src = super.fetchPypi {
                pname = "platformdirs";
                inherit version;
                hash = "sha256-G0K0UK2TPpgdVuWfG5dJVCjJvWBpi6q58+s9ANWCJCE=";
            };
        });
        charset-normalizer = super.charset-normalizer.overridePythonAttrs(old: rec {
            version = "3.1.0";
            src = super.fetchPypi {
                pname = "charset-normalizer";
                inherit version;
                hash = "sha256-NOCi+cNw65VZeq5jv4XrXpaCbYHj3PiLiIYBKQb1CbU=";
            };
        });
        marshmallow = super.marshmallow.overridePythonAttrs(old: rec {
            version = "3.18.0";
            src = super.fetchPypi {
                pname = "marshmallow";
                inherit version;
                hash = "sha256-aATBYRT3/OH1tNrcMfRnSvIzF/zH8HXaIeNcGjXXgfc=";
            };
        });
        marshmallow-dataclass = super.marshmallow-dataclass.overridePythonAttrs(old: rec {
            version = "3.18.0";
            src = super.fetchPypi {
                pname = "marshmallow-dataclass";
                inherit version;
                hash = "sha256-kAMsD9ZQzpS27G3I3+sOP/UMFEWGRiw4m4GgcgW+23g=";
            };
        });
        pygitguardian = super.pygitguardian.overridePythonAttrs(old: rec {
            version = "1.16.0";
            src = super.fetchPypi {
                pname = "pygitguardian";
                inherit version;
                hash = "sha256-kffFRU/PfTN5RvU8NdA15JeSJL9F66he2C+dOTnJBP0=";
            };
        });
        pyjwt = super.pyjwt.overridePythonAttrs(old: rec {
            version = "2.6.0";
            src = super.fetchPypi {
                pname = "PyJWT";
                inherit version;
                hash = "sha256-aShcfjH8RPaKH+swnpSODfUyWdV5KV5s/isXkjKfBf0=";
            };
        });
        python-dotenv = super.python-dotenv.overridePythonAttrs(old: rec {
            version = "0.21.0";
            src = super.fetchPypi {
                pname = "python-dotenv";
                inherit version;
                hash = "sha256-t30IJ0Y549NBRd+mxwCOZt8PBLe+enX9DVKSwZHXkEU=";
            };
        });
        requests = super.requests.overridePythonAttrs(old: rec {
            version = "2.32.0";
            src = super.fetchPypi {
                pname = "requests";
                inherit version;
                hash = "sha256-+lSQMZR0yC7x0sm8RZ02UuOuTvTE690YohFFpHyktrg=";
            };
        });
        urllib3 = super.urllib3.overridePythonAttrs(old: rec {
            version = "2.2.2";
            src = super.fetchPypi {
                pname = "urllib3";
                inherit version;
                hash = "sha256-3VBUhVSaelUoM9peYGNjnQ0XfATyO8OGTkHl3F9hIWg=";
            };
        });
        rich = super.rich.overridePythonAttrs(old: rec {
            version = "12.5.1";
            src = super.fetchPypi {
                pname = "rich";
                inherit version;
                hash = "sha256-Y6XFzjZz09X7vyPNh+EauEtrRRQ28bfxnsVLa8Nu18o=";
            };
        });
    };
  in pkgs.python3.override {inherit packageOverrides; self = python3;};
in
{
  # ggshield = pkgs.callPackage ./ggshield.nix { python3 = python3;};
  ggshield = pkgs.callPackage ./ggshield.nix {};
}
