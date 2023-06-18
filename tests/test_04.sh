#!/bin/bash
# README example 2
cat << EOF | diff - <(seq 1 10 | pawk --start 'c=0' --each 'c+=1' --end 'print(f"line count: {c}")')
line count: 10
EOF
