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
echo "Extracting template app..."

base64 -d <<EOF | tar xz
H4sIAAAAAAAAA+1YbW/bNhD2ZwP+D4yCYnagUJKtFyBDMThLsGJAt6ItBgxFYFMSY7OVRY0vbrNfvyMlvw3JggKzO2B8kMji8fjcieQdT3p7O715fYtXZe94CAFpHPfCNIyyJNr9dkgn4140SbMsStIknfTCKJxkWQ+FR/RpCy0VEQj1arp+qE9h8L+FczStKr6mQlJEmgYpumoqouigP+i/XzKJ4I/Uh0oY/c41KkA86H8QlJSI5FyrQ6W74VKpRl4FAdmIccFXQUnXtOLNJajIYDTo8z3y7yT6THPJFMXG/mzWSKl89ADW5JLrqkRSr1ZEsD/BRF0i+gV8ZbVREKgR/CMtFFpSQc9mM0Nwfo5uWnOsXhjBtGkqVhDFwKqEQQWFpxMUAce80iSYW7vvOTKbQiG1bCfF2Cp4XRt6BmK+mRIwX1B0zwXMm1RgxEdC14ZjPp8P+tg+e0CkZFKZHkQ2g2Be7I7DtiXxwSTZ4adZf+vgkW2YGM+S5Mn4B2ziP47T0MR/GIc9lBzZL4v/efzvbdCj2Xh2/dNsu/6TJIP1jyZh7PL/KXB+FmgpgooXpApovUY5kUuTwGix5MjbpXRInWhq9wmplfet3Xb4l2DjP+dcYTj/jmTjufov28V/Mo5iE/9JlLr4PwVkIVij3hC1RC+hFFp8CO8GfSmKGyZAIJWAogZLnQ93ij6K/E3PPavLgy5vBQWZ2Uve6HIM5V3F8o7KcmLsBRgHIPVMkmlI8YksoOZpWgc2rFysiBp6L+T3L2TwA5bc89GBrt/xjXYcj1IM+giwJQK/zI3Z9JpdmorP/D8qZ3lQNKvqyc6m2o31/NbOviudqHWza7ST8XRj0B+ZWRH0D80EHXogNVZrqjzo+LFitFbwiNv+1iVc2A6jotkj3ZqZrp20abzRdv3NMxx7j31F/ZeEKeiZjBC7+u8UMOu/Cdlj2Xg2/yeb9U8ncTix9d84dPn/FLCFHyo2qaXNMV3aNMdBdOejLonOZm/e/vrzL9PXt7OZZ1NVO9i8Ib809eGwpbE5rOPltRK8uuZElKADyeidFvfwwjuE22uu61IOQx+FOIOLD0Yi00jMJRptDeRaKXhht+Ov7f3+cGwJQjvIcoR47G8ueywLQfJX8CZf0Zbpp217jw1ddubtZfJ3urGh23+oK1KW73S+ZvTzsHXzHxR2HtgpavUxr6eFYmuiqJmie10X5vPEcNQdKXCawUn4ikIuPzN5nNalGWw+w5i4/Q2IYdhH/Ynm/IuVX3WfKgyFaQoNbE+tP14wxRY1F/R4e+y5+A+TePv9L23rvwjSgIv/E8DW/xcXwQUuqwr2y675ANXHvkDyb+2rg4ODg4ODg4ODg4ODg4ODg8PX4y/10lnPACgAAA==
EOF

sed -i "s#__PROJNAME__#${PROJNAME}#g" lua/main.lua

echo
echo "Fetching git dependencies..."

mkdir -p allo/deps
git submodule add https://github.com/alloverse/alloui-lua allo/deps/alloui
git submodule update --init --recursive allo/deps/alloui

echo
echo "Downloading binaries..."
mkdir -p allo/lib