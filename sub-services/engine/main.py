#!/usr/bin/env python3

import json
import os
from datetime import date, datetime

import pika
from elasticsearch import Elasticsearch, RequestsHttpConnection


def main():
    credentials = pika.PlainCredentials(
        username='dpline',
        password='dpline'
    )
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(host='rabbitmq', credentials=credentials)
    )
    channel = connection.channel()
    payload = open('/alert1.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    channel.basic_publish(exchange='quality_gates_exchange',
                          routing_key='quality_gates_key',
                          body=payload)
    payload = open('/alert2.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    channel.basic_publish(exchange='quality_gates_exchange',
                          routing_key='quality_gates_key',
                          body=payload)
    payload = open('/alert3.json', 'rb').read()
    payload_json = json.loads(payload.decode('utf-8'))
    payload_json['date'] = datetime.now().isoformat()
    payload = json.dumps(payload_json).encode('utf-8')
    channel.basic_publish(exchange='quality_gates_exchange',
                          routing_key='quality_gates_key',
                          body=payload)
    connection.close()

    es = Elasticsearch(
        "https://localhost:9200",
        http_auth=('elastic', os.getenv("ELASTIC_PASSWORD")),
        verify_certs=False,
        connection_class=RequestsHttpConnection
    )
    today = date.today()
    es.indices.refresh(index="quality-gates-index-{0}".format(today))


if __name__ == "__main__":
    print("main - start")
    main()
    print("main - end")
