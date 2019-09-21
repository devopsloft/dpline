#!/usr/bin/env python3

import requests
import sys


def main():
    files = {'file': open('index.json', 'rb')}
    response = requests.post(
        url="http://localhost:9200/api/qualit_gates_index",
        headers={"Content-Type": "application/json"},
        files=files
    )
    if response.status_code != 200:
        print(response.content)
        sys.exit(1)


if __name__ == "__main__":
    print("elasticsearch - start")
    main()
    print("elasticsearch - end")
