{
    pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
    nativeBuildInptus = with pkgs; [
        jdk
        kotlin
        kotlin-language-server
        ktlint
    ];

    buildInputs = with pkgs; [
        gradle
        jbang
    ];

    JAVA_HOME = pkgs.jdk.home;

    shellHook = ''
        echo "☕ Kotlin development environment loaded!"
        echo "Kotlin: $(kotlin -version 2>&1)"
        echo "Ktlint: $(ktlint --version)"
    '';
}
