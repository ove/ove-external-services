#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

cd ${scriptPath}/../../

if [[ -d tuoris ]]; then
    cd tuoris
    git pull
    cd ..
else
    git clone --branch v0.1 https://github.com/fvictor/tuoris
fi

cd tuoris/
npm install
