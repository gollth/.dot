#!/usr/bin/env python3

import os
import re
import subprocess

from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument('-4', dest='ipv4', action='store_true', default=None, help="Only print IPv4 addresses")
parser.add_argument('-6', dest='ipv6', action='store_true', default=None, help="Only print IPv6 addresses")
parser.add_argument('--mac', action='store_true', default=None, help="Only print MAC address of EtherNET links")

parser.add_argument('-x', dest='print_header', action='store_false', help="Skip the header of the table")
parser.add_argument('ifname', nargs='?', default='', help="Filter for specific interface name")

args = parser.parse_args()
all_protocols = args.ipv4 is None and args.ipv6 is None and args.mac is None

process = subprocess.run(
    'ip address show'.split(),
    check=True,
    capture_output=True
)

# Convert each block to "oneline" representation
output = re.sub(r'\n\s+', ' ', process.stdout.decode('utf-8'))

pattern_ipv4 = re.compile(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,3}')
pattern_ipv6 = re.compile(r'([0-9a-f]{0,4}::){0,7}[0-9a-f]+\/\d+')
pattern_mac  = re.compile(r'([0-9a-f]{2}:){5}[0-9a-f]{2}')

prints = []

if args.print_header:
    prints.append(['Interface', 'Address', 'Mask'])
    prints.append(['---------', '-------', '----'])

for interface in output.splitlines():
    parts = interface.split()
    name = parts[0][:-1]   # remove trailing colon

    # Skip this interface if tis name does not match user predicate
    if not args.ifname in name:
        continue

    # Include either IPv4 or IPv6 addresses, or both, depending on user selection
    ips = []
    if args.ipv4 or all_protocols:
        ips.extend(addr.split('/') for addr in parts if pattern_ipv4.search(addr))

    if args.ipv6 or all_protocols:
        ips.extend(addr.split('/') for addr in parts if pattern_ipv6.search(addr) and '.' not in addr)

    if args.mac:
        ips.extend([addr, None] for addr in parts if pattern_mac.search(addr))

    # Concnatinate the tuples (name, addr, mask) to the prints list
    for addr, mask in ips:
        prints.append([name, addr, '' if mask is None else '/'+mask])

# Nice pretty printing with aligned columns
widths = [max(map(len, col)) for col in zip(*prints)]
for row in prints:
    print('  '.join((value.ljust(width) for value, width in zip(row, widths))))
