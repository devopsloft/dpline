#!/usr/bin/env python3

import requests


def main():
    s = requests.session()
    url = "http://localhost:5601/api/saved_objects/index-pattern/quality-gates-index-*" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('index-pattern.json', 'rb').read()
    response = s.post(
        url=url,
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/search/quality-gates-search"
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('search.json', 'rb').read()

    response = s.post(
        url=url,
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/visualization/quality-gates-visualization" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('visualization.json', 'rb').read()

    response = s.post(
        url=url,
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)

    url = "http://localhost:5601/api/saved_objects/dashboard/quality-gates-dashboard" # noqa
    headers = {"kbn-xsrf": "reporting", "Content-Type": "application/json"}
    payload = open('dashboard.json', 'rb').read()

    response = s.post(
        url=url,
        headers=headers,
        data=payload
    )
    if response.status_code != 200:
        print(response.content)


if __name__ == "__main__":
    main()
