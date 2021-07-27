#!/usr/bin/env python3

# pip install: pyquery PrettyTable
import sys
import urllib.error
from argparse import ArgumentParser
from pyquery import PyQuery as pq
from prettytable import PrettyTable

parser = ArgumentParser()
parser.add_argument('search', help='Which command to you need?')
parser.add_argument('os', nargs='*', help='For which system do you want to install the command?')
parser.add_argument('-r', '--raw', action='store_true', help="Don't pretty print the result, useful for scripting")
parser.add_argument('-s', '--sudo', action='store_true', help="Prepend 'sudo' before all commands, useful for scripting")

args = parser.parse_args()


try:
  page = pq(f'https://command-not-found.com/{args.search}', headers={'User-Agent': 'Mozilla/5.0'})

  dl = page('dl')
  rows = [
      [dd.attr('data-os'), ('sudo ' if args.sudo else '') + dd('code').text()]
      for dd in dl('.command-install[data-os]').items()
      if not args.os or any(os.lower() in dd.attr('data-os').lower() for os in args.os)
  ]
  if args.raw:
      for [os, cmd] in rows:
        print(cmd)
      sys.exit(0)


  table = PrettyTable()
  table.align = 'l'
  table.field_names = ['OS', 'Command']
  table.add_rows(rows)
  table.align = 'l'

  print(table)

except urllib.error.HTTPError as e:
  print(f'No results found for command "{args.search}"')
  print(e)
  sys.exit(1)
