#!/bin/bash
# defaultdict
cat << EOF | diff - <(pawk --file data/numbers.csv -H --begin 'd=defaultdict(str)' 'for w in words: d[w]=1' \
     --end 'print(f"distinct words: {len(d.keys())}")')
distinct words: 6
EOF
