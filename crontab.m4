m4_changequote(`[', `]')m4_dnl
m4_changecom()m4_dnl
m4_define(COMMAND, [(date; bin/$1.sh) >>logs/$1.log 2>&1])m4_dnl
# m h  dom mon dow   command
[SITE]=SITE

# Run regular tests
* * * * * COMMAND(ping-test)
m4_ifelse(
    SITE, 32karalta,  [0 8,12,16,20 * * * COMMAND(ookla-test)],
    SITE, 31bay,      [0 8,12,16,20 * * * COMMAND(ookla-test)],
    [0 8,12,16,20 * * * COMMAND(ookla-test)]
)

# Regular cleanup 
0 * * * * COMMAND(cleanup)

# Regularly summary & upload
*/15 * * * * COMMAND(summarise); COMMAND(upload)

# Update the scripts from the central setup
59 * * * * COMMAND(software-update)

# Locally execute a central admin script
*/15 * * * * COMMAND(central-admin)

