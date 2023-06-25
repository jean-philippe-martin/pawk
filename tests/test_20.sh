#!/bin/bash
# numerical columns in YAML
cat << EOF | diff - <(pawk --file data/planets.yaml --each 't += word["number of satellites"]' --end 'print(f"total number of satellites: {t}")')
total number of satellites: 205
EOF
