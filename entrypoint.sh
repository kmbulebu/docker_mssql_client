#!/bin/bash
set -e

if [[ -z "${SQL_SLEEP_TIME}" ]]; then
  sleeptime=0
else
  sleeptime=$SQL_SLEEP_TIME
fi

sleep $sleeptime

# Set SQL_FILES_PATH to the directory containing .sql files.

# See https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility for
# full list of supported environment variables.

# Create database
sqlcmd -d '' -Q "CREATE DATABASE $SQLCMDDBNAME;"

SQL_BASE_PATH=`dirname $SQL_FILES_MANIFEST`

# Build files args
while read line; do
  filename=$SQL_BASE_PATH/$line
  FILE_ARGS=`echo $FILE_ARGS"-i $filename " | tr -d "\n\r"`
done < $SQL_FILES_MANIFEST

#for filename in "$SQL_FILES_PATH"/*.sql; do
#  FILE_ARGS=$FILE_ARGS"-i $filename "
#done

sqlcmd $FILE_ARGS
