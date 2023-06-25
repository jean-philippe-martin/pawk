#!/bin/bash
# print planets from YAML
cat << EOF | diff - <(pawk --file data/planets.yaml --print 'word["planet"]')
Mercury
Venus
Earth
Mars
Jupiter
Saturn
Uranus
Neptune
EOF
