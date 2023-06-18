#!/bin/bash
# regular expression
cat << EOF | diff - <(pawk --file data/numbers.csv 'if re.match(r"o.*", words[1]): print(line)')
1,one
EOF
