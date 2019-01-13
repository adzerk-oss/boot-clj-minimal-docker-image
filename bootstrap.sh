#!/usr/bin/env bash

if [ `uname` = "Darwin" ]; then
  USER_UID=1000
  USER_GID=50
else
  USER_UID=$(id -u)
  USER_GID=$(id -g)
fi

host_project=$PWD
container_project=$PWD

host_boot=${BOOT_HOME:-$HOME/.boot}
container_boot=$HOME/.boot

host_m2=${BOOT_LOCAL_REPO:-$HOME/.m2/repository}
container_m2=$HOME/.m2/repository

mkdir -p $host_boot $host_m2 .dockerhome

docker run --rm \
  -v $PWD/.dockerhome:$HOME \
  -v $host_boot:$container_boot \
  -v $host_m2:$container_m2 \
  -v $host_project:$container_project \
  -e USER_NAME=$USER \
  -e USER_UID=$USER_UID \
  -e USER_GID=$USER_GID \
  -e USER_HOME=$HOME \
  -e PROJECT_DIR=$container_project \
  adzerk/boot-clj-minimal:0.1.1 boot ${argz}
