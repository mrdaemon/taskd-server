#!/usr/bin/env bash
export TASKDDATA=/var/taskd

# Refresh example configuration
if [[ -d $TASKDDATA/example ]] ; then
    rm -rf "$TASKDDATA/example"
fi

mkdir -p $TASKDDATA/example || exit 1
taskd init --data "$TASKDDATA/example"

# Hand off to taskd
exec taskd server
