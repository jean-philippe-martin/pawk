#!/bin/bash
# README example 3 (ish)
cat << EOF | diff - <(seq 1 10 | pawk 'c+=1' --end 'print(f"line count: {c}")')
line count: 10
EOF
