#!/bin/bash
# test print
cat << EOF | diff - <(pawk --file data/numbers.csv -H --print 'words[0]')
1
2
3
EOF
