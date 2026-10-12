"""Predicts the next high tide from the last one."""

from datetime import datetime, timedelta

SEMI_DIURNAL_PERIOD = timedelta(hours=12, minutes=25)


def predict_next_high(last_high: datetime) -> datetime:
    return last_high + SEMI_DIURNAL_PERIOD
