"""Formats a tide for display."""

from datetime import datetime


def render_high_tide(at: datetime, height_m: float) -> str:
    return f"High tide {at:%H:%M} UTC, {height_m} m"
