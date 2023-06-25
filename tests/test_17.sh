#!/bin/bash
# toml
cat << EOF | diff - <(pawk --file data/implicit-and-explicit-before.toml --print 'word["a"]')
{'better': 43, 'b': {'c': {'answer': 42}}}
EOF
