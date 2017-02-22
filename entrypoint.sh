#!/bin/bash

if [ "${1}" != "srdb" ]; then
	exec $@
fi

srdb $@
exit 0

