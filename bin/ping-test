#!/bin/bash
source $(dirname $(readlink -f $0))/configure

function mainline()
{
    DATE=$(date "+%Y-%m-%d")
    (
        flock -w30 99 || exit 1
        run-test >> $BASEDIR/logs/ping-test.$DATE.log
        run-extras-if-needed $BASEDIR/logs/ping-test.$DATE.log
    ) 99>$BASEDIR/locks/ping-test.lock
}

function run-test()
{
    # Compute the count to finish in a rounded minute
    local SECOND=$(date "+%_S")
    local DURATION=$(( 60 - $SECOND ))

    # Log the start time, and do the ping
    date "+%Y-%m-%d %H:%M:%S"
    ping -n -w $DURATION -i 0.5 $PING_TARGET
}

function run-extras-if-needed()
{
    local LOSS=$(
        tail "$1" |
            sed -n -r '/packet loss/ {s/.* ([0-9]+)% packet loss.*/\1/; p}'
    )

    if [ "$LOSS" -ge $PING_TRACEROUTE_THRESHOLD ]
    then
        $BASEDIR/bin/traceroute-test.sh
    fi

    if [ "$LOSS" -ge $PING_OOKLA_THRESHOLD ]
    then
        $BASEDIR/bin/ookla-test.sh
    fi
}

mainline

