#!/bin/bash
# all the "begin" variants can be used, and they don't change the order.
# Also, it's OK to have a program with no "--each" statement.
cat << EOF | diff - <(echo hi | pawk --first 'print("first")' --before 'print("before")' --begin 'print("begin")' --start 'print("start")')
first
before
begin
start
EOF
