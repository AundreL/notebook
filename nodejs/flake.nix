{
   description = "A reproducible Node.js development environment flake";

   inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   };

   outputs =
      { self, nixpkgs }:
      let
         # Define systems you want to support
         supportedSystems = [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
         ];

         # Native helper to generate attributes across all matching systems
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
                  packages = with pkgs; [
                     # Core Node.js Runtime & Package Managers
                     nodejs # Pins Node.js to stable v22 (LTS)
                     corepack # Safely manages pnpm and yarn without global npm installs

                     # Language Server, Linters, and Formatters
                     vtsls # Modern, ultra-fast TypeScript/JavaScript Language Server
                     typescript # Underlying compiler (tsc) required by the LSP
                  ];

                  # Hook environment variables or shell initializations
                  shellHook = ''

                     echo "⚡ Node.js Development Environment Loaded!"
                     echo "Versions:"
                     echo "  - Node: $(node --version)"
                     echo "  - Corepack: $(corepack --version)"
                     echo "  - TypeScript: $(tsc --version)"
                     echo "  - Prettier: $(prettier --version)"
                  '';
               };
            }
         );
      };
}
