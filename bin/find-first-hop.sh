#!/bin/bash

set -e
SELF=$(readlink -f $0)
SELFDIR=$(dirname $SELF)
. $SELFDIR/config.sh

function mainline()
{
    /usr/sbin/traceroute -n 8.8.8.8 > $BASEDIR/logs/find-first-hop.log
    find-first-hop < $BASEDIR/logs/find-first-hop.log
}

function find-first-hop()
{
    perl -n -e '
        use strict;
        use English;
        use List::Util qw(sum);

        if (/^\s+ \d+ \s+ (\d+\.\d+\.\d+\.\d+) \s+/x)
        {
            my ($ip, $rest) = ($1, $POSTMATCH);

            my @sample;
            while ($rest =~ /([0-9.]+) \s+ ms/xg)
            {
                push(@sample, $1);
            }

            my $count = @sample;
            if ($count >= 2)
            {
                my $avg = sum(@sample) / $count;
                if ($avg > 6 and $ip !~ /^192\.168\./)
                {
                    print "$ip\n";
                    exit(0);
                }
            }
        }
    '
}

mainline
