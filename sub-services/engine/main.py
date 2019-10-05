#!/usr/bin/env python3

import json
from datetime import date, datetime

from elasticsearch import Elasticsearch


def main():
    es = Elasticsearch("http://elasticsearch:9200")
    today = date.today()
    payload = open('/alert1.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    es.index(
        index="quality-gates-index-{0}".format(today),
        refresh=True,
        body=payload
    )

    payload = open('/alert2.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    es.index(
        index="quality-gates-index-{0}".format(today),
        refresh=True,
        body=payload
    )


if __name__ == "__main__":
    print("main - start")
    main()
    print("main - end")
