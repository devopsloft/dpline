#!/usr/bin/env python3

from datetime import date

from elasticsearch import Elasticsearch


def main():
    es = Elasticsearch("http://localhost:9200")
    today = date.today()
    es.indices.create(
        index="quality-gates-index-{0}".format(today),
        ignore=400
    )


if __name__ == "__main__":
    print("elasticsearch - start")
    main()
    print("elasticsearch - end")
