from datetime import datetime

from src.forecast.predict import predict_next_high


def test_next_high_is_one_semi_diurnal_period_later() -> None:
    assert predict_next_high(datetime(2026, 1, 1, 0, 0)) == datetime(2026, 1, 1, 12, 25)
