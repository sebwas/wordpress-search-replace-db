#!/usr/bin/env bash

function print_help_text {
	echo "USAGE: ${0} SEARCH REPLACE"
}

TEXT_PORTION=

function extract_text_portion {
	if [ $# -lt 1 ]; then
		echo "Internal Error."
		exit 2
	fi

	TEXT_PORTION=$(grep -oP "(['\"]).*?\1" ${1} | grep -A 1 ${2:-DB_NAME} | tail -n 1 | grep -o "[^'\"]*")

	return $?
}

if [ $# -lt 1 ]; then
	print_help_text
	exit 1
fi

shift
PARAMS=
for var in "$@"; do
	if [ "${var:0:1}" = "-" ]; then
		PARAMS=$PARAMS $var
		shift
	fi
done

CONFIG_FILE=${CONFIG_FILE:-/tmp/wp-config.php}

extract_text_portion $CONFIG_FILE "DB_NAME"
DB_NAME=$TEXT_PORTION

extract_text_portion $CONFIG_FILE "DB_HOST"
DB_HOST=$TEXT_PORTION

extract_text_portion $CONFIG_FILE "DB_USER"
DB_USER=$TEXT_PORTION

extract_text_portion $CONFIG_FILE "DB_PASS"
DB_PASS=$TEXT_PORTION

echo "Invoking $SCRIPT_PATH/srdb.cli.php -u ${DB_USER} -p ${DB_PASS} -n ${DB_NAME} -h ${DB_HOST} -s ${1} -r ${2} $PARAMS"

$SCRIPT_PATH/srdb.cli.php -u ${DB_USER} -p ${DB_PASS} -n ${DB_NAME} -h ${DB_HOST} -s ${1} -r ${2} $PARAMS

