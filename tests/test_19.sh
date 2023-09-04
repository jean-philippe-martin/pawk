#!/bin/bash
set -e # exit on error
# print planets from CSV
cat << EOF | diff - <(pawk --file data/planets.csv -H --print 'word["planet"]')
Mercury
Venus
Earth
Mars
Jupiter
Saturn
Uranus
Neptune
EOF
# same, but now from stdin
cat << EOF | diff - <(cat data/planets.csv | pawk --mode csv -H --print 'word["planet"]')
Mercury
Venus
Earth
Mars
Jupiter
Saturn
Uranus
Neptune
EOF

