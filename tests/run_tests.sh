#!/bin/bash
for i in test_*.sh; do
  if "./${i}"; then
     echo "${i} OK"
  else
     echo "${i} FAIL"
  fi
done
