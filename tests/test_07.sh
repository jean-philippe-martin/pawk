#!/bin/bash
# README example (adapted)
cat << EOF | diff - <(seq 1 10 | pawk 'if not d: old_line=line;d=1' 'else: print(f"{old_line[:40]:<40}{line[:40]}");d=0 ' --last 'if d: print(old_line)')
1                                       2
3                                       4
5                                       6
7                                       8
9                                       10
EOF
