# Copyright 2019 Arie Bregman
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

import argparse


def create_list_parser(subparsers, pparser):
    """The parser for sub command 'list'."""
    list_parser = subparsers.add_parser("list", parents=[pparser])
    list_parser.add_argument('--services', '-s',
                             dest="list_services",
                             help='List all the supported services.')


def create_deploy_parser(subparsers, pparser):
    """The parser for sub command 'deploy'."""
    deploy_parser = subparsers.add_parser("deploy", parents=[pparser])
    deploy_parser.add_argument(
        '--directly', '-d', dest="directly", action='store_true',
        default=False,
        help='Deploy Dpline directly on your environment, without a VM')


def create_parser():
    """Returns argument parser"""

    # Top level parser
    parent_parser = argparse.ArgumentParser(add_help=False)
    main_parser = argparse.ArgumentParser()

    main_parser.add_argument('--debug', '-d', action='store_true',
                             dest="debug", help='Turn on debug')

    action_subparsers = main_parser.add_subparsers(
        title="sub-actions", dest="main_command")

    create_list_parser(action_subparsers, parent_parser)
    create_deploy_parser(action_subparsers, parent_parser)

    return main_parser
