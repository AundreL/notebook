{
    description = "Go development environment with LSP and linter";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs =
        { self, nixpkgs }:
        let
            # Supported systems for the development shell
            supportedSystems = [
                "x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"
            ];

            # Helper function to generate an attrset for each system
            forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
        in
        {
            devShells = forAllSystems (
                system:
                let
                    pkgs = import nixpkgs { inherit system; };
                in
                {
                    default = pkgs.mkShell {
                        buildInputs = with pkgs; [
                            # Core Go compiler & tooling
                            go

                            # Language Server Protocol (LSP)
                            gopls

                            # Linter aggregator
                            golangci-lint

                            # Optional helper tools for Go development
                            gotools # includes godoc, goimports, etc.
                            delve # Go debugger
                        ];

                        shellHook = ''

                            echo "🐹 Welcome to the Go development environment!"
                            echo "Tools available: $(go version), gopls, golangci-lint"

                            # Ensure local Go cache binaries don't conflict with Nix mappings
                            export GOPATH="$HOME/.go"
                            export PATH="$GOPATH/bin:$PATH"
                        '';
                    };
                }
            );
        };
}
