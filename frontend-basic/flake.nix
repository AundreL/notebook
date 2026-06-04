{
   description = "Development environment for HTML, CSS, and JavaScript formatting";

   inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   };

   outputs =
      { self, nixpkgs }:
      let
         supportedSystems = [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
         ];
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
                     # The core multi-language formatter
                     nodePackages.prettier

                     # Optional: Minimal Node runtime if you need to execute script files or npm scripts
                     nodejs_22
                  ];

                  shellHook = ''

                     echo "⚡ HTML, CSS, and JavaScript environment loaded!"
                     echo "👉 Run 'prettier --check .' to inspect your code syntax formatting."
                     echo "👉 Run 'prettier --write .' to format your files instantly."
                  '';
               };
            }
         );
      };
}
