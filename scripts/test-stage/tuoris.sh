#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

cd ${scriptPath}/../../tuoris

npm test