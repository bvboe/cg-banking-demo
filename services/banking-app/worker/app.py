# app.py
import time

import pandas as pd


def run_once() -> None:
    df = pd.DataFrame(
        {
            "a": [1, 2, 3, 4],
            "b": [10, 20, 30, 40],
        }
    )
    print(df.mean(), flush=True)


if __name__ == "__main__":
    while True:
        run_once()
        time.sleep(60)
