#!/bin/bash
# multiple prints
cat << EOF | diff - <(pawk --file data/numbers.csv -H --print 'words[0]' --print 'words[1]')
1
one
2
two
3
three
EOF
