from datetime import datetime

from src.ui.render import render_high_tide


def test_high_tide_is_rendered_in_utc_and_metres() -> None:
    assert render_high_tide(datetime(2026, 1, 1, 12, 25), 4.2) == "High tide 12:25 UTC, 4.2 m"
