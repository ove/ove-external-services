#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

cd ${scriptPath}/../../

if [[ -d tuoris ]]; then
    cd tuoris
    git pull
    cd ..
else
    git clone https://github.com/fvictor/tuoris.git
fi

cd tuoris/
npm install