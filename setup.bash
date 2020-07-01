#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

echo "Alloverse app setup wizard"
echo "--------------------------"

if [ -f "allo" ]; then
    echo "Project already initialized; use \`./allo/assist upgrade\` to fetch latest version."
    exit
fi

read -p "Create new project in $(pwd)? (y/N) " answer
if [ "$answer" != "y" ] ; then
    echo "Exiting..."
    exit
fi

echo
echo "Extracting template app..."

base64 -d <<EOF | tar xz
H4sIAAAAAAAAA+2YbWvbMBCA89ng/6A6lCUlle3GL7AxRlj7cTBGv4xSEsXRYm22pUlytu7X72TnlbWEwpwOpoeEVHfS3Vmnk49+uplcf7jB5aLXHQGQRFEvSIIwjcPd75pkfNULx0mahnESJ+NeEAbjNO2hoMOYttRKE4lQr6Krh+oUDv8t+mhSFHxFpaKICIE0LUVBNHUd17nNmULwIdXhJIw+8xplIHadO0nJApE5r/XhpPtBrrVQr32fbMQ446W/oCtacHEJU5Q/dB2+Z/yVQj/oXDFNsfE/nQql9Ag9gDeV87pYIFWXJZHsF7ioFoj+hFhZZSZIJCT/SjONcirp2XRqDPT76Lp1x6qlEUyEKFhGNAOvChZlFJ5OUgQ2ZkVN/Fnj95Yjcyg00nm7KcZXxqvKmGcg5pstAfcZRV+4hH1TGpyMkKwrY2M2m7kObp7dJ0oxpY0Gkc0i2JfmxOFmpPDBJjXLT5P/JsCOfZgaT+P4yfoHNvUfRUlg6j+Igh6KO46r4T+v/70D2pmPo/lP0m3+x3EK+Q/HQWTv/1PQP/NrJf2CZ6TwabVCc6Jyc4HRLOfI213pcHWiSXNOSKW9lw7b8pdo6n/Oucbw/uvIx7H+L93Vf3wVRqb+4zCx9X8KVCaZ0B+JztFbaIWWd8G96yiZXTMJAqUlNDVY1fPBbuIIhaON5gurFgcqr4SGzJwlb3h5Be1dweZrU41NjD0fYx+knrlkBMm+kSX0PKINYGOVy5LogXeu3pwr/x1W3Buhg7mjtb3hzsajJlwHAVtDEJf5wxz6ml2ajs98H5WzuZ+JsnhSKYrdWm/U+tkPZS1qw1wP2s14euA6Q7Mrkn6vmaQDD6TGa0W1B4r3BaOVhkfc6tuQcNYozJSaPaKumVHtpEJ4w23+zTN0fcae0f/FQQLzzI0Q2f7vFJj8b0q2Kx/H7v8/8g/9Xxja+/8U4CXTbFlxSbvzcTT/cbT9/0/Svv/DYGzzfwqa/u/iwr/Ai6Jwnb3hA7x99gWKv3SsFovFYrFYLBaLxWKxWCwWi+V5/Abb6CIQACgAAA==
EOF

echo
echo "Downloading binaries..."


exit 0
START OF DATA