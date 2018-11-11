#!/bin/bash

scriptPath=$(dirname "$(readlink -f "$0")")
cd ${scriptPath}/

TEMPLATES_PATH="templates"

export GENERATED_PATH="generated"
mkdir -p ${GENERATED_PATH}

function deactivate_env {
  echo "Deactivating env variables ..."
  unset SERVICE_VERSION
  unset SERVICE_NAME
  unset SERVICE_PORT
  unset GENERATED_PATH
}

function display_help() {
  echo "Build image for external service"
  echo
  echo "usage: build.sh [option]..."
  echo "   -s, --service     The name of the service to build, same as the folder name"
  echo "   -p, --port        The port(s) exposed by the service"
  echo "   --chrome          Include chrome in the build"
  echo "   --push            Push the image"
  echo "   -v, --version     The version of the service"
}

version=`git describe --tags --exact-match 2> /dev/null`
if [ $? -ne 0 ]; then
  version="latest"
fi

pushImage=false
BASE_IMAGE="Dockerfile"

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      display_help
      exit 0
      ;;
    -s|--service)
      service="$2"
      shift
      ;;
    -p|--port)
      port="$2"
      shift
      ;;
    --chrome)
      BASE_IMAGE="Dockerfile.chrome"
      ;;
    -v|--version)
      version="$2"
      echo "Recognized user version = ${version}"
      shift
      ;;
    --push)
      pushImage=true
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

export SERVICE_VERSION=${version}
export SERVICE_NAME=${service}
export SERVICE_PORT=${port}

trap deactivate_env EXIT SIGINT SIGTERM

echo "Using version = ${SERVICE_VERSION}"

if [[ ! -d "${SERVICE_NAME}" ]]; then
  echo "Invalid service = ${SERVICE_NAME} provided"
  exit 1
fi

if [[ -z "${SERVICE_PORT}" ]]; then
  echo "Invalid port provided"
  exit 1
fi

echo "Building service = ${SERVICE_NAME} exposing port = ${SERVICE_PORT} using baseImage = ${BASE_IMAGE}"

envsubst < ${TEMPLATES_PATH}/docker-compose.yml > ${GENERATED_PATH}/docker-compose.${SERVICE_NAME}.yml
envsubst < ${TEMPLATES_PATH}/${BASE_IMAGE} > ${GENERATED_PATH}/Dockerfile.${SERVICE_NAME}
envsubst < ${TEMPLATES_PATH}/pm2.json > ${SERVICE_NAME}/pm2.json

docker-compose -f ${GENERATED_PATH}/docker-compose.${SERVICE_NAME}.yml build
if [ $? -ne 0 ]; then
  # fail if the image build process failed
  exit 1
fi

if [ "${pushImage}" = true ]; then
  docker-compose push
fi

