{
    description = "Kotlin development environment";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs =
        { self, nixpkgs }:
        let
            supportedSystems = [
                "x86_64-linux" # 64-bit Intel/AMD Linux
            ];

            forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
        in
        {
            devShells = forAllSystems(system:
            let
            in {};

            );
        };
}
