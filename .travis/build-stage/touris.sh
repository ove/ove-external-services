#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

cd ${scriptPath}/../../

./build.sh -s tuoris -p 7080 --chrome