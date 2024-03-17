#!/bin/bash

set -e
SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

TEMPFILE=/tmp/logs.$$.gz
trap 'rm -f $TEMPFILE' EXIT

# Create package to upload
cd $BASEDIR/logs
tar cz --mode=640 $(find -mmin -360 \( -name "*.log" -o -name "*.csv" \) | sort ) > $TEMPFILE

# Upload the package
curl -X POST -F "output=@$TEMPFILE" $URLBASE/upload.php

