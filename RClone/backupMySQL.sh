#!/bin/bash

# RClone Environments
SERVER_NAME=SN-179
RCLONE="/usr/sbin/rclone"
TIMESTAMP=$(date +"%F")
PROJECT_NAME=FI_NETWORK
BACKUP_DIR="/backup/$PROJECT_NAME/mysql_$TIMESTAMP"


# Database info
DB_HOST=mysql-production-db.demo.poolata.com
DB_PORT=1239
DB_NAME=facmine
DB_USER=facmineuser
DB_PASSWORD=facmineuserpass

echo "Starting Backup Data"

mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/data"
cd "$BACKUP_DIR/data"

# Dumping database
echo "Dumping database"
mysqldump -h $DB_HOST -u $DB_USER –p $DB_PASSWORD $DB_NAME > "mysql_$TIMESTAMP.sql"

# Upload
zip -r "$BACKUP_DIR/data/data.zip" "/backup"
$RCLONE move $BACKUP_DIR/data/data.zip "drive:$SERVER_NAME/$BACKUP_DIR/data"
echo "Finished"
echo ''

# Clean up
rm -rf $BACKUP_DIR
$RCLONE -q --min-age 2M delete "drive:$SERVER_NAME" #Remove all backups older than 2 month
$RCLONE -q --min-age 2M rmdirs "drive:$SERVER_NAME" #Remove all empty folders older than 2 month

$RCLONE cleanup "drive:" #Cleanup Trash
echo "Finished"
find /backup -mindepth 1 -maxdepth 1 -type f -ctime +30 -exec rm -r {} \;
