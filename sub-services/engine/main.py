#!/usr/bin/env python3

import requests
import json
from datetime import date, datetime


def main():
    today = date.today()
    s = requests.session()
    payload = open('/alert1.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    response = s.post(
        url="http://elasticsearch:9200/quality-gates-index-{0}/_doc".format(today),  # noqa
        headers={"Content-Type": "application/json"},
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    payload = open('/alert2.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    response = s.post(
        url="http://elasticsearch:9200/quality-gates-index-{0}/_doc".format(today),  # noqa
        headers={"Content-Type": "application/json"},
        data=payload
    )
    if response.status_code != 200:
        print(response.content)


if __name__ == "__main__":
    print("main - start")
    main()
    print("main - end")
