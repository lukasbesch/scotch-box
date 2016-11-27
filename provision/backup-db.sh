#!/bin/bash

#mysqldump --lock-all-tables -u root --all-databases > /var/www/current-dump.sql

USER="root"
PASSWORD="root"
OUTPUT="/var/www/dumps"

mkdir -p $OUTPUT

databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
		mkdir -p "$OUTPUT/$db"
        DATETIME="$(date +%F) $(date +%R):$(date +%S)"
        mysqldump -u $USER -p$PASSWORD --databases $db > "$OUTPUT/$db/$DATETIME.$db.sql"
		find $OUTPUT/$db/* -mtime +5 -exec rm {} \;
    fi
done