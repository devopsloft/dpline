#!/usr/bin/env python3

import requests


def main():
    requests.post(
        "http://localhost:5601/api/sample_data/flights",
        headers={"kbn-xsrf": "reporting"}
    )


if __name__ == "__main__":
    main()
