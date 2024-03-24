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
        run-test >> $BASEDIR/logs/ookla-test.$DATE.log
    ) 99>$BASEDIR/locks/ookla-test.lock
}

function run-test()
{
    # Log the start time, and do the ping
    date "+%Y-%m-%d %H:%M:%S"
    speedtest
}

mainline

