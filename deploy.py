#!/usr/bin/env python3

import json
import logging
import os
import sys
import time
from datetime import date

import requests
from dotenv import load_dotenv
from elasticsearch import Elasticsearch, RequestsHttpConnection
from requests.auth import HTTPBasicAuth
from requests.exceptions import ConnectionError


def wait_for_elasticsearch():
    max_tries = 50
    attempt = 0
    while True and attempt < max_tries:
        attempt += 1
        try:
            return requests.head(
                url='https://localhost:9200',
                auth=HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD')),
                verify='/certs/ca/ca.crt'
            )
        except ConnectionError:
            logging.info("Elasticsearch server is not ready yet")
            time.sleep(5)
    logging.error("Elasticsearch server is not ready yet")
    sys.exit()


def set_kibana_password():
    headers = {"Content-Type": "application/json"}
    payload = {
        "password": os.getenv("ELASTIC_PASSWORD")
    }
    auth = HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD'))
    requests.put(
        url='https://localhost:9200/_xpack/security/user/kibana/_password',
        auth=auth,
        verify='/certs/ca/ca.crt',
        headers=headers,
        data=json.dumps(payload)
    )


def wait_for_kibana():
    max_tries = 50
    attempt = 0
    while True and attempt < max_tries:
        attempt += 1
        try:
            response = requests.head(
                url='http://localhost:5601/login',
                auth=HTTPBasicAuth('kibana', os.getenv('ELASTIC_PASSWORD'))
            )
            if response.status_code != 200:
                logging.info("Kibana server is not ready yet")
                time.sleep(5)
            else:
                return
        except ConnectionError:
            logging.info("Kibana server is not ready yet")
            time.sleep(5)
    logging.error("Kibana server is not ready yet")
    sys.exit()


def main():
    load_dotenv(dotenv_path='/vagrant/.env')
    wait_for_elasticsearch()
    set_kibana_password()
    wait_for_kibana()

    es = Elasticsearch(
        "https://localhost:9200",
        http_auth=('elastic', os.getenv("ELASTIC_PASSWORD")),
        verify_certs=False,
        connection_class=RequestsHttpConnection
    )
    today = date.today()
    es.indices.create(
        index="quality-gates-index-{0}".format(today),
        ignore=400
    )
    s = requests.session()
    url = "http://localhost:5601/api/saved_objects/index-pattern/quality-gates-index-*" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('/vagrant/index-pattern.json', 'rb').read()
    response = s.post(
        url=url,
        auth=HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD')),
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/search/quality-gates-search"
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('/vagrant/search.json', 'rb').read()

    response = s.post(
        url=url,
        auth=HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD')),
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/visualization/quality-gates-visualization" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('/vagrant/visualization.json', 'rb').read()

    response = s.post(
        url=url,
        auth=HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD')),
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/dashboard/quality-gates-dashboard" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('/vagrant/dashboard.json', 'rb').read()

    response = s.post(
        url=url,
        auth=HTTPBasicAuth('elastic', os.getenv('ELASTIC_PASSWORD')),
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)


if __name__ == "__main__":
    logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
    main()
