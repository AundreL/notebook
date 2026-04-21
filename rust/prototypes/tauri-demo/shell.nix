# Run with `nix-shell shell.nix`
let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cargo 
    cargo-tauri # Optional, Only needed if Tauri doesn't work through the traditional way.
    rustc # Needed for dev server (npm tauri dev)
    
    pkg-config
    wrapGAppsHook4
    nodejs # Optional, this is for if you have a js frontend
  ];

  buildInputs = with pkgs; [
    nodePackages."@angular/cli"
    librsvg
    webkitgtk_4_1
  ];

  shellHook = ''
    export XDG_DATA_DIRS="$GSETTINGS_SCHEMAS_PATH" # Needed on Wayland to report the correct display scale
  '';
}
