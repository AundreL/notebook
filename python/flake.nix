{
    description = "A clean Python development environment";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs =
        { self, nixpkgs }:
        let
            # Define the systems you want to support natively
            supportedSystems = [
                "x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"
            ];

            # Native helper to map over the supported systems without flake-utils
            forEachSupportedSystem =
                f:
                nixpkgs.lib.genAttrs supportedSystems (
                    system:
                    f {
                        pkgs = import nixpkgs { inherit system; };
                    }
                );
        in
        {
            devShells = forEachSupportedSystem (
                { pkgs }:
                {
                    default = pkgs.mkShell {
                        # The packages you want available in your shell
                        packages = with pkgs; [
                            python312 # The core Python interpreter
                            python312Packages.pip # Package manager

                            # Development Tooling
                            uv # project manager
                            pyright # Excellent Python Language Server
                            ruff # Blazing fast Rust-based linter and formatter
                        ];

                        # Shell hook that runs immediately when you enter the environment
                        shellHook = ''

                            echo "🐍 Welcome to the Python Nix shell!"
                            echo "Python version: $(python --version)"

                            # Optional: Ensure virtualenv uses the local project directory
                            export PIP_PREFIX=$(pwd)/_build/pip_packages
                            export PYTHONPATH="$PIP_PREFIX/${pkgs.python311.sitePackages}:$PYTHONPATH"
                            export PATH="$PIP_PREFIX/bin:$PATH"
                        '';
                    };
                }
            );
        };
}
