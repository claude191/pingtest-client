#!/bin/bash

set -e
SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

TEMPFILE=/tmp/logs.$$.tar.gz
trap 'rm -f $TEMPFILE' EXIT

# Create package to upload
cd $BASEDIR/logs

# Tar up the logs, but don't stop on errors - tar often returns a non-zero status
# when files change whilst it is reading them.
set +e
tar cz --mode=640 $(find -mmin -360 \( -name "*.log" -o -name "*.csv" \) | sort ) > $TEMPFILE

# Upload the package
curl --silent --show-error --request POST --form "output=@$TEMPFILE" $BASEURL/upload.php
md5sum $TEMPFILE

