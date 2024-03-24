
# Where things live locally and remotely
BASEDIR=$HOME
BASEURL="https://pingtest.falam.net/$SITE"

# Ping target on even/odd day-of-month/hour-of-day
eval $(date "+HOUR=%_H DAY=%_d" | sed 's/= /=/g')
if [[ $(( DAY % 2 ))  == 0 ]]; then DAY="even";  else DAY="odd";  fi
if [[ $(( HOUR % 2 )) == 0 ]]; then HOUR="even"; else HOUR="odd"; fi

case "$DAY/$HOUR" in
    even/even)  PING_TARGET=8.8.8.8 ;;  # Google
    even/odd)   PING_TARGET=8.8.4.4 ;;  # Google
    odd/even)   PING_TARGET=1.1.1.1 ;;  # Cloudflare
    odd/odd)    PING_TARGET=1.0.0.1 ;;  # Cloudflare
esac

# Extra tests if ping-loss reaches this percentage
PING_TRACEROUTE_THRESHOLD=10
PING_OOKLA_THRESHOLD=10

