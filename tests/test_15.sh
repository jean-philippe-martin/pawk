#!/bin/bash
# json (one object)
cat << EOF | diff - <(pawk --file data/jsonarray.json --each 'a += word["age"]' --print 'word["name"]' --end 'print(f"sum of ages: {a}")')
John
Bob
sum of ages: 50
EOF
