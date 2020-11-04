#!/usr/bin/env bash
# ___PLACEHOLDERWARN

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Windows;;
    MINGW*)     machine=Windows;;
    *)          machine="UNKNOWN:${unameOut}"
esac


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

if [[ "$machine" == "Mac" ]]
then
    baseargs="-D"
else
    baseargs="-d"
fi
base64 $baseargs <<EOF | tar xz
BASE64ENCODEDTGZ
EOF

sed -i".bak" "s#__PROJNAME__#${PROJNAME}#g" lua/main.lua
rm lua/main.lua.bak

echo
echo "FETCHING git dependencies..."

mkdir -p allo/deps
git submodule add https://github.com/alloverse/alloui-lua allo/deps/alloui
git submodule update --init --recursive allo/deps/alloui
git submodule add https://github.com/luapower/luajit.git allo/deps/luajit-bin

echo
echo "DOWNLOADING libraries using assist..."

./allo/assist upgrade
