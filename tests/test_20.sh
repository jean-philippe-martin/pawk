#!/bin/bash
set -e
# numerical columns in YAML
cat << EOF | diff - <(pawk --file data/planets.yaml --each 't += word["number of satellites"]' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF
# same, but from stdin
cat << EOF | diff - <(cat data/planets.yaml | pawk --mode yaml --each 't += word["number of satellites"]' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF
