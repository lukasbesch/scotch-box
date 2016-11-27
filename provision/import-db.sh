#!/bin/bash

USER="root"
PASSWORD="root"
OUTPUT="/var/www/dumps"

databases=`ls $OUTPUT`

for db in $databases; do
	LATEST="$OUTPUT/$db/$(ls -r $OUTPUT/$db | head -n 1)"
	mysql -u $USER -p$PASSWORD < "$LATEST"
done