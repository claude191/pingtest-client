
# Change the ping target from Google to Superloop
if [ $PING_TARGET = 8.8.8.8 ]; then
    PING_TARGET=119.40.106.35
fi

if [ $PING_TARGET = 8.8.4.4 ]; then
    PING_TARGET=119.40.106.36
fi

# Override the thresholds
PING_TRACEROUTE_THRESHOLD=4
PING_OOKLA_THRESHOLD=4

