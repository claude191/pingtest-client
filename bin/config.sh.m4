m4_changequote(`[', `]')m4_dnl

# Where things live on this host
BASEDIR=$HOME

# The server location
BASEURL="https://pingtest.falam.net/$SITE"

m4_dnl Default ping locations are Google and Cloudflare
m4_define([PING_EE], [8.8.8.8])m4_dnl
m4_define([PING_EO], [8.8.8.8])m4_dnl
m4_define([PING_OE], [1.1.1.1])m4_dnl
m4_define([PING_OO], [1.0.0.1])m4_dnl

m4_dnl Override some ping locations
m4_ifelse(
    SITE, 32karalta,
        [m4_define([PING_EE], [119.40.106.35])m4_dnl 
        m4_define([PING_EO], [119.40.106.36])m4_dnl]
)

# Ping target on even/odd day-of-month/hour-of-day
eval $(date "+HOUR=%_H DAY=%_d" | sed 's/= /=/g')
if [[ $(( DAY % 2 ))  == 0 ]]; then DAY="even";  else DAY="odd";  fi
if [[ $(( HOUR % 2 )) == 0 ]]; then HOUR="even"; else HOUR="odd"; fi

case "$DAY/$HOUR" in
    even/even)  PING_TARGET=PING_EE ;;
    even/odd)   PING_TARGET=PING_EO ;;
    odd/even)   PING_TARGET=PING_OE ;;
    odd/odd)    PING_TARGET=PING_OO ;;
esac

# Extra tests if ping-loss reaches this percentage
PING_TRACEROUTE_THRESHOLD=4
PING_OOKLA_THRESHOLD=4

