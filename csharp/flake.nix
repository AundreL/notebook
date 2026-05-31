{
    description = "C# Development Environment with LSP and Linter";

    inputs = {
        nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    };

    outputs =
        { self, nixpkgs }:
        let
            system = "x86_64-linux"; # Change to "aarch64-linux", "x86_64-darwin", or "aarch64-darwin" if needed
            pkgs = import nixpkgs { inherit system; };
        in
        {
            devShells.${system}.default = pkgs.mkShell {
                buildInputs = with pkgs; [
                    # 1. The .NET SDK (combines runtime, compiler, and built-in dotnet format linter)
                    dotnet-sdk_8

                    # 2. Language Server (OmniSharp)
                    omnisharp-roslyn

                    # 3. Code Formatting / Additional Linting
                    csharpier # Opinionated code formatter (like Prettier for C#)
                ];

                shellHook = ''

                    echo "⚡ C# Dev Shell Activated ⚡"
                    echo "SDK Version: $(dotnet --version)"
                    echo "LSP (OmniSharp): $(omnisharp --version)"
                    echo "Linter/Formatter: $(csharpier --version)"

                    # Optional: Prevents OmniSharp from looking at global mono installations
                    export OMNISHARP_PATH="${pkgs.omnisharp-roslyn}/bin/OmniSharp"
                '';
            };
        };
}
