{
    pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
    nativeBuildInptus = with pkgs; [
    ];

    buildInputs = with pkgs; [
        jdk
        kotlin
        kotlin-language-server
        gradle
        jbang
        ktlint
    ];

    JAVA_HOME = pkgs.jdk.home;
    env = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
    };

    shellHook = ''
        export LANG="en_US.UTF-8"
        export LC_ALL="en_US.UTF-8"

        echo "☕ Kotlin development environment loaded!"
        echo "Kotlin: $(kotlin -version 2>&1)"
        echo "Ktlint: $(ktlint --version)"

        exec fish
    '';
}
