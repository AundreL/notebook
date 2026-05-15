pkgs: attrs:
let
    defaultAttrs = {
        builder = "${pkgs.bash}/bin/bash";
        args = [ ./builder-v2.sh ];
        baseInputs = with pkgs; [
            gnutar
            gzip
            gnumake
            gcc
            coreutils
            gawk
            gnused
            gnugrep
            binutils.bintools
        ];
        buildInputs = [ ];
        system = builtins.currentSystem;
    };
in
derivation (defaultAttrs // attrs)
