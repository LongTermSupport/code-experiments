"""Write a greeting, hiding any failure to write it."""

import contextlib
import sys


def main() -> None:
    """Write the greeting to standard output, silencing every error."""
    with contextlib.suppress(Exception):
        sys.stdout.write("Hello, world\n")


if __name__ == "__main__":
    main()
