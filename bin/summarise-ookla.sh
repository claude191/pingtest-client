#!/bin/bash

set -e

SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

function mainline()
{
    cd $BASEDIR/logs

    for LOG in ookla-test.*.log
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
    echo "datetime,upMbps,downMbps,latencyMs,jitterMs,resultUrl"

    perl -n -e '

        if (/^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)/)
        {
            $stamp = $1;
        }

        if (/Latency:\s+(\S+) ms\s+\((\S+) ms/)
        {
            ($latency, $jitter) = ($1, $2);
        }

        if (/Download:\s+(\S+) Mbps/)
        {
            $down = $1;
        }

        if (/Upload:\s+(\S+) Mbps/)
        {
            $up = $1;
        }

        if (/Result URL:\s+(\S+)/)
        {
            $url = $1;

            print "$stamp,$up,$down,$latency,$jitter,$url\n";
        }
    '
}

mainline

