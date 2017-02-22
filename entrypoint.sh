#!/bin/bash

if [ "${1}" != "srdb" ]; then
	exec $@
fi

exec srdb $@

