#!/usr/bin/python3 -u
"""
Replace SQL parameters in SQL queries to aid debugging.

Credits: Script was written by Julian Trischler
"""

import re
import sys


def is_int(s):
    try:
        int(s)
    except ValueError:
        return False
    else:
        return True


def print_last_unprocessed_sql():
    global sql
    if sql:
        print(sql)
        sql = ""


PARAM_RE = re.compile(r"(\$\d+) = '([^']+)'")

sql = ""
try:
    # The iter trick is to read immediately and bypass the line buffering.
    for line in iter(sys.stdin.readline, ""):
        line = line.strip()
        if line.startswith("execute "):
            print_last_unprocessed_sql()
            sql = line
        elif line.startswith("parameters: "):
            for parameter_name, parameter_value in PARAM_RE.findall(line):
                # Try to guess whether we have to readd the single quotes around the parameter
                # value or not. By default everything is quoted by Postgres. But we don't need
                # them for numbers.
                val = parameter_value if is_int(parameter_value) else ("'%s'" % parameter_value)
                sql = re.sub(re.escape(parameter_name) + r'\b',
                             "%s /* %s */" % (val, parameter_name),
                             sql, 1)
            print(sql)
            sql = ""
        else:
            print_last_unprocessed_sql()
            print(line)
except KeyboardInterrupt:
    pass

print_last_unprocessed_sql()
