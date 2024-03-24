#!/bin/bash

set -e
SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh


function mainline()
{
    cd $BASEDIR/logs

    for LOG in ping-test.*.log
    do
        BASE=$(basename $LOG .log)
        if [ $SELF -nt $BASE.csv -o $LOG -nt $BASE.csv ]
        then
            summarise <$LOG >$BASE.tmp
            mv $BASE.tmp $BASE.csv
        fi
    done
}

function summarise()
{
    echo "datetime,loss%"

    perl -n -e '

        if (/^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)/)
        {
            $stamp = $1;
        }

        if (/packets transmitted.*, ([0-9.]+)% packet loss/)
        {
            print "$stamp,$1\n";
        }
    '
}

mainline

