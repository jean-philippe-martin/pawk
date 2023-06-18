#!/bin/bash
# json (one object)
cat << EOF | diff - <(pawk --file data/onejson.json --print 'word["nested"]["a"]')
1
EOF
