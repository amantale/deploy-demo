#!/bin/bash -e

CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}$1${CLEAR}\n"
  fi
  echo "Usage: $0 -a action-name -t tag"
  echo "  -a, --action-name    action    The action you want to perform. Can be start, stop or reset (start+stop)"
  echo "  -t, --tag-version    version   Tag version of the docker images of the microservices you want to run locally"
  echo ""
  echo "Example: $0 -a reset -t v2023-11-03-aaaa"
  exit 1
}

while [[ "$#" -gt 0 ]]; do case $1 in
  -h | --help)
    usage
    exit 0
    ;;
  -a | --action-name)
    ACTION_NAME="$2"
    shift
    shift
    ;;
  -t | --tag_version)
    TAG="$2"
    shift
    shift
    ;;
  *)
    usage "Unknown parameter passed: $1"
    shift
    shift
    ;;
  esac done

# verify params
if [[ -z "$ACTION_NAME" ]]; then usage "Action name name is not set"; fi
if [[ -z "$TAG" ]]; then usage "Tag version is not set"; fi

# check param values so we don't mess up
if ! [[ "$ACTION_NAME" =~ ^(start|stop|reset)$ ]]; then
  echo "Valid values for action name are one of [start, stop, reset]"
  exit 1
fi

start() {
  echo "Starting services"
  echo "Pulling the lastest versions for all microservices"
  docker pull deploydemo.jfrog.io/docker/microservice1:$TAG
  docker pull deploydemo.jfrog.io/docker/microservice2:$TAG

  echo "Starting the microservices"
  docker run --name microservice1 -d -p 8080:8080 deploydemo.jfrog.io/docker/microservice1:$TAG
  echo "microservice1 was started on port 8080"
  docker run --name microservice2 -d -p 8081:8081 deploydemo.jfrog.io/docker/microservice2:$TAG
  echo "microservice2 was started on port 8081"
}

stop() {
  echo "Stopping the services"
  docker rm --force microservice1
  docker rm --force microservice2
}

reset() {
  echo "Executing restart"
  stop
  sleep 2
  start
}

if [[ "$ACTION_NAME" == "start" ]]; then
  start
fi

if [[ "$ACTION_NAME" == "stop" ]]; then
  stop
fi

if [[ "$ACTION_NAME" == "reset" ]]; then
  reset
fi


