#!/bin/bash
source $(dirname $(readlink -f $0))/configure

$BASEDIR/bin/summarise-ping.sh
$BASEDIR/bin/summarise-ookla.sh

