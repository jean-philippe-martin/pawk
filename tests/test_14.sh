#!/bin/bash
# json (one object)
cat << EOF | diff - <(pawk --file data/onejson.json --print 'word["two"]')
2
EOF
