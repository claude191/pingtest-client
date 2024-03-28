#!/bin/bash
source $(dirname $(readlink -f $0))/configure

function mainline()
{
    cd $BASEDIR

    git pull
    m4 -P --define=SITENAME=$SITENAME crontab.m4 | crontab
}

mainline

