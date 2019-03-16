#!/usr/bin/env python

import jenkins
import xml.etree.ElementTree as ET
import os


def convert_xml_file_to_str():
    tree = ET.parse(os.path.dirname(os.path.abspath(__file__)) + '/config.xml')
    root = tree.getroot()
    return ET.tostring(root, encoding='utf8', method='xml').decode()


def main():
    server = jenkins.Jenkins('http://localhost:8080', username='dpline',
                             password='dpline')
    user = server.get_whoami()
    version = server.get_version()
    print('Hello %s from Jenkins %s' % (user['fullName'], version))
    config = convert_xml_file_to_str()
    server.create_job('e2e', config)
    server.build_job('e2e', {'data': 'first artifact'})
    server.build_job('e2e', {'data': 'second artifact'})
    server.build_job('e2e', {'data': 'third artifact'})


if __name__ == "__main__":
    main()
