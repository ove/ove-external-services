#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

cd ${scriptPath}/../../

if [[ -d tuoris ]]; then
    cd tuoris
    git fetch
    cd ..
else
    git clone https://github.com/fvictor/tuoris
fi

cd tuoris/
git checkout v0.1

npm install
