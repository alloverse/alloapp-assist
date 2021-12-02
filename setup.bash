#!/bin/bash
# This file is generated! Edit setup-script.bash instead. See README for more details.

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

read -p "Create new project '$PROJNAME'? (Y/n) " answer
if [ "$answer" == "n" ] ; then
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
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
EOF

sed -i".bak" "s#__PROJNAME__#${PROJNAME}#g" lua/main.lua
rm lua/main.lua.bak

echo
echo "FETCHING git dependencies..."

mkdir -p allo/deps
git submodule add -f https://github.com/alloverse/alloui-lua allo/deps/alloui
git submodule update --init --recursive allo/deps/alloui
git submodule add -f https://github.com/luapower/luajit.git allo/deps/luajit-bin

echo
echo "DOWNLOADING libraries using assist..."

./allo/assist upgrade
