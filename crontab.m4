# m h  dom mon dow   command

# Run regular tests
* *          * * * bin/ping-test.sh
0 8,12,16,20 * * * bin/ookla-test.sh

# Cleanup logs and CSVs after a period
0 0          * * * find logs -name "*.log" -mtime +30 -delete
0 0          * * * find logs -name "*.csv" -mtime +183 -delete

# Regularly summary & upload
*/15 * * * * bin/summarise.sh; bin/upload.sh

# Update the scripts from the central setup
0 * * * * bin/software-update.sh

# Locally execute a central admin script
14-59/15 * * * * bin/central-admin.sh
