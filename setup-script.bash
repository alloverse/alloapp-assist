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
BASE64ENCODEDTGZ
EOF

echo
echo "Downloading binaries..."
