#!/bin/bash

set -e

SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

function mainline()
{
    cd $BASEDIR

    git pull
    m4 -P --define=SITE=$SITE crontab.m4 # | crontab
}

mainline

