# boot-clj-minimal

Runs [Boot][1] in Docker, allowing the user to mount volumes from the host for
the Maven and Boot caches, and the project directory. Also creates the user in
the container and runs Boot as that user so files created by Boot will be owned
by the user and not root.

```bash
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
  --name boot-minimal-$USER \
  -v $PWD/.dockerhome:$HOME \             # home dir
  -v $host_boot:$container_boot \         # boot dir
  -v $host_m2:$container_m2 \             # maven repo dir
  -v $host_project:$container_project \   # project dir
  -e USER_NAME=$USER \                    # user's username in the host
  -e USER_UID=$USER_UID \                 # user's user id in the host
  -e USER_GID=$USER_GID \                 # user's primary group id in the host
  -e USER_HOME=$HOME \                    # user's home dir in the host
  -e PROJECT_DIR=$container_project \     # the project dir ($PWD) in the host
  adzerk/boot-clj-minimal:latest runboot boot build
```
