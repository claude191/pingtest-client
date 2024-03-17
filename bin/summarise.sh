#!/bin/bash

SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

$BASEDIR/bin/summarise-ping.sh
$BASEDIR/bin/summarise-ookla.sh

