#!/bin/bash

set -e
SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

find $BASEDIR/logs -name "*.log" -mtime +30 -delete
find $BASEDIR/logs -name "*.csv" -mtime +183 -delete

