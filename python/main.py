def get_greeting(name: str) -> str:
    """Generate a greeting for the user."""
    return f"🐍 Hello, {name}! Welcome to your reproducible Nix environment."


def main() -> None:
    message = get_greeting("World")
    print(message)


if __name__ == "__main__":
    main()
