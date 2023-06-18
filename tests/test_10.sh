#!/bin/bash
# all the "end" variants can be used, and they don't change the order.
# Also, it's OK to have a program with no "--each" statement.
cat << EOF | diff - <(echo hi | pawk --end 'print("end")' --after 'print("after")' --last 'print("last")' --finish 'print("finish")')
end
after
last
finish
EOF
