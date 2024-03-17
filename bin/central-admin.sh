#!/bin/bash

set -e

SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

(curl --silent $URLBASE/admin.sh | bash) >$BASEDIR/logs/admin.log 2>&1

