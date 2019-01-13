#!/bin/bash

args=()
for i in "$@"; do
  args+=( "$(printf '%q' "$i")" )
done

export argz="${args[*]}"

if [[ $USER_NAME && $USER_GID && $USER_UID && $USER_HOME ]]; then
  addgroup -g $USER_GID $USER_NAME
  adduser -D -h $USER_HOME -G $USER_NAME -s /bin/bash -u $USER_UID $USER_NAME
  exec su $USER_NAME -c "cd $PROJECT_DIR && ${args[*]}"
else
  exec cat /bootstrap.sh |envsubst '$argz'
fi
