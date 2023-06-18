#!/bin/bash
# README example (adapted)
cat << EOF | diff - <(seq 1 10 | pawk --each 'if line.startswith("1"): a = not a; continue
if a:
  print("    " + line)
else:
  print(line)')
    2
    3
    4
    5
    6
    7
    8
    9
EOF
