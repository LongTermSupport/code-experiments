"""Write a greeting."""

import os  # ruff: ignore[F401]
import sys


def main() -> None:
    """Write the greeting to standard output."""
    sys.stdout.write("Hello, world\n")


if __name__ == "__main__":
    main()
