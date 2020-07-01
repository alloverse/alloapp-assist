#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

echo "Alloverse app setup wizard"
echo "--------------------------"

if [ -d "allo" ]; then
    echo "Project already initialized; use \`./allo/assist upgrade\` to fetch latest version."
    exit
fi

PROJNAME=`basename $(pwd)`

read -p "Create new project '$PROJNAME'? (y/N) " answer
if [ "$answer" != "y" ] ; then
    echo "Exiting..."
    exit
fi

if [ ! -d ".git" ]; then
    echo "git init'ing"
    git init
fi

echo
echo "EXTRACTING template app..."

base64 -d <<EOF | tar xz
BASE64ENCODEDTGZ
EOF

sed -i "s#__PROJNAME__#${PROJNAME}#g" lua/main.lua

echo
echo "FETCHING git dependencies..."

mkdir -p allo/deps
git submodule add https://github.com/alloverse/alloui-lua allo/deps/alloui
git submodule update --init --recursive allo/deps/alloui

echo
echo "DOWNLOADING binaries..."
mkdir -p allo/lib