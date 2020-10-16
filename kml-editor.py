#!/usr/bin/env python3

import os
import sys
from argparse import ArgumentParser


parser = ArgumentParser('Edit KML files via Command Line')
parser.add_argument('file', help='Path to KML file to edit')
parser.add_argument('--output', help='Path to output file. Omit to edit input file directly')
command = parser.add_subparsers(help='The function to perform on the KML data', dest='function')
command.required = True
offset = command.add_parser('offset', help='Apply a static offset to each coordinate')
xyz = offset.add_mutually_exclusive_group(required=True)
xyz.add_argument('-x', type=float, help='Add to the X value of each coordinate')
xyz.add_argument('-y', type=float, help='Add to the Y value of each coordinate')
xyz.add_argument('-z', type=float, help='Add to the Z value of each coordinate')

args = parser.parse_args()
print(args)

if args.output is None:
    args.output = args.file

if not os.path.exists(args.file):
    print(f'ERROR: File {args.file} does not exist')
    sys.exit(1)

with open(args.file) as file:
    with open(args.output, 'w') as output:

        for number, line in enumerate(file):
            if number == 0 and not line.startswith('<?xml'):
                print(f'ERROR: File {args.file} does not seem to be in XML format')
                sys.exit(2)

            if number == 1 and not line.startswith('<kml'):
                print(f'ERROR: File {args.file} does not seem to be in KML format')
                sys.exit(3)

            if line.strip().startswith('<gx:coord>'):
                indent = len(line.split('<gx')[0])
                coord = line.strip().replace('<gx:coord>', '').replace('</gx:coord>', '').split()
                coord = [float(c) for c in coord]

                if args.function == 'offset':
                    if args.x is not None: coord[0] += args.x
                    if args.y is not None: coord[1] += args.y
                    if args.z is not None: coord[2] += args.z

                line = f'{" " * indent}<gx:coord>{coord[0]} {coord[1]} {coord[2]}</gx:coord>\n'

            output.write(line)
