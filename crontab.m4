m4_changequote(`[', `]')m4_dnl
m4_changecom()m4_dnl
m4_define(COMMAND, [(date; bin/$1.sh) >>logs/$1.log 2>&1])

# m h  dom mon dow   command
# crontab for site SITE
[SITE]=SITE

# Run regular tests
* * * * * COMMAND(bin/ping-test.sh)
m4_ifelse(
    SITE, 32karalta,  [0 8,12,16,20 * * * COMMAND(ookla-test)],
    SITE, 31bay,      [0 8,12,16,20 * * * COMMAND(ookla-test)],
    [0 8,12,16,20 * * * COMMAND(ookla-test)]
)

# Cleanup logs and CSVs after a period
0 0          * * * COMMAND(cleanup)

# Regularly summary & upload
*/15 * * * * COMMAND(summarise); COMMAND(upload)

# Update the scripts from the central setup
59 * * * * COMMAND(software-update)

# Locally execute a central admin script
14-59/15 * * * * COMMAND(central-admin)

