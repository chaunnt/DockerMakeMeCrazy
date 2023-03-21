#!/bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
cd "$BACKUP_DIR"
USER="user"
PASSWORD="pass"
HOST="dbhost"
PORT=1239
#rm "$OUTPUTDIR/*gz" > /dev/null 2>&1

databases=`mysql --port=$PORT -h $HOST -u $USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| "`

for db in $databases; do
    if [[ "$db" != "Database" ]] && [[ "$db" != "sys" ]] && [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --port=$PORT -h $HOST -u $USER --password=$PASSWORD --databases $db > `date +%Y%m%d`.$db.sql
       # gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done   
