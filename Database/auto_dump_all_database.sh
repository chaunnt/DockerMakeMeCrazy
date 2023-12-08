#!/bin/bash
echo "Start backup"

DB_SERVER=demodatabase.makefamousapp.com
DB_PORT=1235
DB_USER=root
DB_PASS=mysqlpassword

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$DB_SERVER/$TIMESTAMP"
mkdir "/backup"
mkdir "/backup/$DB_SERVER"
mkdir $BACKUP_DIR
cd "$BACKUP_DIR"
echo $DB_PORT
echo $DB_SERVER
echo $DB_USER
echo $DB_PASS
# echo `mysql --port=$DB_PORT -h $DB_SERVER -u $DB_USER --password=$DB_PASS -e "SHOW DATABASES;" | tr -d "| "`
databases=`mysql --port=$DB_PORT -h $DB_SERVER -u $DB_USER --password=$DB_PASS -e "SHOW DATABASES;" | tr -d "| "`

for db in $databases; do
    if [[ "$db" != "Database" ]] && [[ "$db" != "sys" ]] && [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        echo "mysqldump --column-statistics=0 --port=$DB_PORT -h $DB_SERVER -u $DB_USER --password=$DB_PASS --databases $db > `date +%Y%m%d`.$db.sql"
        mysqldump --column-statistics=0 --port=$DB_PORT -h $DB_SERVER -u $DB_USER --password=$DB_PASS --databases $db > `date +%Y%m%d`.$db.sql
       # gzip $OUTPUT/`date +%Y%m%d`.$db.sql
    fi
done   

echo "Finish backup"
