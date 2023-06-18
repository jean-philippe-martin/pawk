#!/bin/bash
# README example 1
cat << EOF | diff - <(echo '/usr/bin:/usr/local/bin' | pawk -F: 'print("\n".join(words))')
/usr/bin
/usr/local/bin
EOF
