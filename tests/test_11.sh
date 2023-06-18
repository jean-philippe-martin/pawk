#!/bin/bash
# it's OK to mix 'each', 'print' and implicit each. Their order is maintained.
cat << EOF | diff - <(seq 1 2 | pawk 'print("A")' --each 'print("B")' -F, 'print("C")')
A
B
C
A
B
C
EOF
