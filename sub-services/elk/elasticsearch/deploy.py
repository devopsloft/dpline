#!/usr/bin/env python3

import requests
import sys
from datetime import date


def main():
    # files = {'file': open('index.json', 'rb')}
    # print(files)
    today = date.today()
    response = requests.put(
        url="http://localhost:9200/quality-gates-index-{0}".format(today),
        headers={"Content-Type": "application/json"}
    )
    if response.status_code != 200:
        print(response.content)
        sys.exit(1)


if __name__ == "__main__":
    print("elasticsearch - start")
    main()
    print("elasticsearch - end")
