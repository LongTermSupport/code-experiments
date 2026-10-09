import contextlib


def main() -> None:
    with contextlib.suppress(Exception):
        print("Hello, world")


if __name__ == "__main__":
    main()
