#!/bin/bash
source $(dirname $(readlink -f $0))/configure

# Cleanup anything that gets old
find $BASEDIR/logs -name "*.log" -mtime +30 -delete
find $BASEDIR/logs -name "*.csv" -mtime +183 -delete

# Cleanup script-named logs that get big (no numbers)
find $BASEDIR/logs -regex ".*/[A-Za-z_-]*.log" -size +1M -delete

