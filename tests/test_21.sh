#!/bin/bash
# numerical columns in CSV need conversion
cat << EOF | diff - <(pawk --file data/planets.csv -H --each 't += int(word["number of satellites"])' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF
