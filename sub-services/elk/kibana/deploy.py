#!/usr/bin/env python3

import requests
import sys


def main():
    files = {'file': open('gates.ndjson', 'rb')}
    response = requests.post(
        url="http://localhost:5601/api/saved_objects/_import",
        headers={"kbn-xsrf": "reporting"},
        files=files
    )
    if response.status_code != 200:
        print(response.content)
        sys.exit(1)


if __name__ == "__main__":
    main()
