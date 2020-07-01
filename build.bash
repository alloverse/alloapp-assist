#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

rm -rf payload.tgz
cd template
tar -czf ../payload.tgz * .gitignore
cd ..

cat setup-script.bash > setup.bash

PAYLOAD=$(base64 -w 0 payload.tgz)
sed -i "s#BASE64ENCODEDTGZ#${PAYLOAD}#g" setup.bash