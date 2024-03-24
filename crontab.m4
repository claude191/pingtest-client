m4_changequote(`[', `]')m4_dnl
m4_changecom()m4_dnl
m4_define(COMMAND, [(echo `date` - '$1'; $1) >>logs/crontab.log 2>&1])

# m h  dom mon dow   command
# crontab for site SITE
[SITE]=SITE

# Run regular tests
* * * * * COMMAND(bin/ping-test.sh)
m4_ifelse(
    SITE, 32karalta,  [0 8,12,16,20 * * * COMMAND(bin/ookla-test.sh)],
    SITE, 31bay,      [0 8,12,16,20 * * * COMMAND(bin/ookla-test.sh)],
    [0 8,12,16,20 * * * COMMAND(bin/ookla-test.sh)]
)

# Cleanup logs and CSVs after a period
0 0          * * * COMMAND(find logs -name "*.log" -mtime +30 -delete)
0 0          * * * COMMAND(find logs -name "*.csv" -mtime +183 -delete)

# Regularly summary & upload
*/15 * * * * COMMAND(bin/summarise.sh; bin/upload.sh)

# Update the scripts from the central setup
59 * * * * COMMAND(bin/software-update.sh)

# Locally execute a central admin script
14-59/15 * * * * COMMAND(bin/central-admin.sh)

