#!/bin/bash
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
