"""Write a greeting."""

import sys


def main() -> None:
    """Write the greeting to standard output."""
    greeting: int = "Hello, world\n"
    sys.stdout.write(greeting)


if __name__ == "__main__":
    main()
