#!/bin/bash

set -e

SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

function mainline()
{
    DATE=`date "+%Y-%m-%d"`

    (
        flock -w30 99 || exit 1
        run-test >> $BASEDIR/logs/traceroute-test.$DATE.log 2>&1
    ) 99>$BASEDIR/locks/traceroute-test.lock
}

function run-test()
{
    # Log the start time, and do the traceroute
    date "+%Y-%m-%d %H:%M:%S"
    traceroute -n $PING_TARGET
}

mainline

