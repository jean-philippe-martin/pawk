#!/bin/bash
set -e # exit on error
# test print
cat << EOF | diff - <(pawk --file data/numbers.csv -H --print 'words[0]')
1
2
3
EOF

# same, from stdin
cat << EOF | diff - <(cat data/numbers.csv | pawk --mode csv -H --print 'words[0]')
1
2
3
EOF
