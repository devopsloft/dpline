#!/usr/bin/env python

import os
import json
import requests


def versions_get_current(sub_service_name):
    versions_file_path = os.path.dirname(__file__) + '/versions.json'
    if os.path.exists(versions_file_path):
        with open(versions_file_path, "r") as infile:
            versions = json.load(infile)
            print(versions[sub_service_name]['current'])


def jenkins_discover_version():
    r = requests.get('http://updates.jenkins.io/stable/latestCore.txt')
    jenkins_stable_version = r.text

    versions_file_path = os.path.dirname(__file__) + '/versions.json'

    if os.path.exists(versions_file_path):
        with open(versions_file_path, "r") as infile:
            versions = json.load(infile)
            if jenkins_stable_version > versions['jenkins']['current']:
                versions['jenkins']['next'] = jenkins_stable_version
            else:
                versions['jenkins']['next'] = ""
            with open(versions_file_path, "w") as outfile:
                json.dump(versions, outfile, indent=4)


def jenkins_plugin_discover_version(name):
    r = requests.get('http://updates.jenkins.io/plugin-versions.json')
    plugin_versions = json.loads(r.text)

    plugin_latest_version = 0
    for key in plugin_versions['plugins'][name]:
        if key > plugin_latest_version:
            plugin_latest_version = key

    versions_file_path = os.path.dirname(__file__) + '/versions.json'

    if os.path.exists(versions_file_path):
        with open(versions_file_path, "r") as infile:
            versions = json.load(infile)
            if plugin_latest_version > versions[name]['current']:
                versions[name]['next'] = plugin_latest_version
            else:
                versions[name]['next'] = ""
            with open(versions_file_path, "w") as outfile:
                json.dump(versions, outfile, indent=4)


def main():
    jenkins_discover_version()
    jenkins_plugin_discover_version('jdk-tool')
    jenkins_plugin_discover_version('rabbitmq-publisher')


if __name__ == "__main__":
    main()
