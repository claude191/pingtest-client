
# Cannot do anything without a site
if [ "$SITE" = "" ]; then
    echo "$SELF: variable SITE is not defined" >&2
    exit 1
fi

# Load the default settings
. $SELFDIR/config.default.sh

# Override the defaults via site-specific file
if [ -e $SELFDIR/config.$SITE.sh ]; then
    . $SELFDIR/config.$SITE.sh
fi

