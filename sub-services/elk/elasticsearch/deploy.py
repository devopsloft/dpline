#!/usr/bin/env python3

import requests
import sys
from datetime import date


def main():
    today = date.today()
    s = requests.session()
    response = s.put(
        url="http://localhost:9200/quality-gates-index-{0}".format(today),
        headers={"Content-Type": "application/json"}
    )
    if response.status_code != 200:
        print(response.content)
        sys.exit(1)

    payload = open('alert1.json', 'rb').read()
    response = s.post(
        url="http://localhost:9200/quality-gates-index-{0}/_doc".format(today),
        headers={"Content-Type": "application/json"},
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    payload = open('alert2.json', 'rb').read()
    response = s.post(
        url="http://localhost:9200/quality-gates-index-{0}/_doc".format(today),
        headers={"Content-Type": "application/json"},
        data=payload
    )
    if response.status_code != 200:
        print(response.content)


if __name__ == "__main__":
    print("elasticsearch - start")
    main()
    print("elasticsearch - end")
