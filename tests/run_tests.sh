#!/bin/bash

# This script runs all the tests, showing feedback on the screen.

for i in test_*.sh; do
  if "./${i}"; then
     echo "${i} OK"
  else
     echo "${i} FAIL"
  fi
done
