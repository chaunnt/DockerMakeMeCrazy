#!/bin/bash
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"

DB_HOST=cdn-pro-db-db.cdn.out
DB_PORT=1233
DB_USER=root
DB_PASSWORD=cdn-pro-db-password

#rm "$OUTPUTDIR/*gz" > /dev/null 2>&1

Echo $(date -u) "backup start"

cd "$BACKUP_DIR"
databases=`mysql --port=$DB_PORT -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD -e "SHOW DATABASES;" | tr -d "| "`

for db in $databases; do
    if [[ "$db" != "Database" ]] && [[ "$db" != "sys" ]] && [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo $(date -u) "Dumping database: $db"
        echo $(date -u) "mysqldump --column-statistics=0 --port=$DB_PORT -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD --databases $db > `date +%Y%m%d`.$db.sql"
        mysqldump --column-statistics=0 --port=$DB_PORT -h $DB_HOST -u $DB_USER --password=$DB_PASSWORD --databases $db > `date +%Y%m%d`.$db.sql
       # gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done

Echo $(date -u) "backup done"