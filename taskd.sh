#!/usr/bin/env bash
export TASKDDATA=/var/taskd

if [[ ! -w $TASKDDATA ]] ; then
    >&2 echo "Warning: Home directory \"$TASKDDATA\" is not writable."
    >&2 echo "  Did you set permissions on the volume correctly?"
fi

# Refresh example configuration
if [[ -d $TASKDDATA/example ]] ; then
    rm -rf "$TASKDDATA/example"
fi

mkdir -p "$TASKDDATA/example" || exit 1
taskd init --data "$TASKDDATA/example"

# Print version and diagnostics to logs
taskd diagnostics --data "$TASKDDATA"

# Hand off to taskd
exec taskd server
