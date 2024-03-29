#!/bin/bash
set -e
# regular expression
cat << EOF | diff - <(pawk --file data/numbers.csv 'if re.match(r"o.*", words[1]): print(line)')
1,one
EOF

# Same, from stdin
cat << EOF | diff - <(cat data/numbers.csv | pawk --mode csv 'if re.match(r"o.*", words[1]): print(line)')
1,one
EOF
