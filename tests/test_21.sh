#!/bin/bash
set -e
# numerical columns in CSV need conversion
cat << EOF | diff - <(pawk --file data/planets.csv -H --each 't += int(word["number of satellites"])' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF
# same, from stdin
cat << EOF | diff - <(cat data/planets.csv | pawk --mode csv -H --each 't += int(word["number of satellites"])' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF

