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
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/OayuaNzD0pfu+3BM89YdMqMJ169KB6/8XN7/2fDV7YffeOxx/Se9vXffaQcN9lw4uFz37vpqKNnzd168bGPPEScl4s3f9S/z+jZ5+6v/HrGPzzwwNw35lwpvZl59aFzO5/Lfpg/5P2nEvF3J7ad88QbK8ofT31t77t/f9jSM/YaXb/5yz+9+PIlp237cvK226633jvnD6/fd95X7B8qxx37s4Vn/X7o4Au37PXS4rND6wdmPvTkz370h1e/drNRPPfeOdsff/ypQ+a82LF92Q2jNzx167H3X/352R/MUp798ORnvnbAFQsahieOfq3p8EvS0abDH37yZ42fP+ndj8icW8yv6y0hZeLQxxYf/+u9ybtvH7PgypfGnGVy5Pj3bpxo22/rttMblqTis5XShd/fuqLY9uZzt1yS7u9+7aBLZs9c/KurV69Lnrz9cm3d4V8fPe5vvmRceesP317zS3L/bw/+277D7j3x+0ND+5n5Wesv+/ZD7a37T4W7Dj383rOOv/+qy/bf964/fveM/244+JqL3/rdGy/98Llr7lPbuieP/fbWGT94euWjTWbDaT91ztyoL7nju4tGnr/n0iuGyPs/OHDBlTdObkwe9r9aztv3N9bcNU+uW3/kj88+4hU1d/M/fyv2pS+8teDA23645NGTjOTDv3qj69YXlj7adMYvYxcf+dDz784be/Lp19W53zjq+PfbD3xt8rQvzzv9+SOk6H7jH6xd9PGZW/fdq+sbh5xxyxVW+uPUHxcsje73zVet0FefveWO/N1n9IbX/3LmZerguR8f+Nh/ffWqR05/5t+Vq7/1vasG77pnr+vCN141sfcvrjz1d3fdGZWvT7+/6Oqrtq08uiE0uuX3ez2+9fabnn33bvuOaLT/3dMOm2q4dObzl0e+9qf/nrVmaPvTcx6//SdtHU9f0t6w/fG+8PMjrz319eJ7ia/csmmw46aZN374USR64dv7rvzxT5KgLy91LWjt29gw//Vr/vbaj6+IXqLcMfV+5q7L1s155J3wwgevffPsI7v2WfJR04MXnNe24pg3zE0X/eM/7je09vYDH73z72ff/KXl13/jvf+44Tszl7SVGm5If2Nu5wX/vv3ii/74/FkH/fO6FYfefsBFo+sff/AZaPt7n179p3kT97fPuLp3zRfu+MHnHv5e38Fzjpx4+4XHnliRH3yD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
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
