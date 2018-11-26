#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")

function deactivate_env {
  echo "Deactivating env variables ..."
}

function display_help() {
  echo "Execute command for external service"
  echo
  echo "usage: execute.sh [option]..."
  echo "   --command     The name of the service to build, same as the folder name"
}

serviceCommand=""

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      display_help
      exit 0
      ;;
    --command)
      serviceCommand="$2"
      shift
      ;;
    *)
      echo "Unrecognised option: $key"
      echo
      display_help
      exit 1
      ;;
  esac
  shift
done

trap deactivate_env EXIT SIGINT SIGTERM

for c in $(find ${scriptPath}/${serviceCommand}-stage/ -type f -name "*.sh"); do
  bash ${c}
done