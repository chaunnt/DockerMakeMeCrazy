#!/bin/bash

# RClone Environments
SERVER_NAME=SN-179
RCLONE="/usr/sbin/rclone"
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/mysql_$TIMESTAMP"

# Database info
DB_HOST=nettruyen-db.makefamousapp.com
DB_PORT=1235
DB_NAME=nettruyen
DB_USER=nettruyenuser
DB_PASSWORD=nettruyenuserpass

echo "Starting Backup Data"

mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/data"
cd "$BACKUP_DIR/data"

# Dumping database
echo "Dumping database"
mysqldump -h $DB_HOST -u $DB_USER –p $DB_PASSWORD $DB_NAME > "mysql_$TIMESTAMP.sql"

# Upload
zip -r "$BACKUP_DIR/data/data.zip" "/backup"
$RCLONE move $BACKUP_DIR/data/data.zip "drive:$SERVER_NAME/$TIMESTAMP/data"
echo "Finished"
echo ''

# Clean up
rm -rf $BACKUP_DIR
$RCLONE -q --min-age 2M delete "drive:$SERVER_NAME" #Remove all backups older than 2 month
$RCLONE -q --min-age 2M rmdirs "drive:$SERVER_NAME" #Remove all empty folders older than 2 month

$RCLONE cleanup "drive:" #Cleanup Trash
echo "Finished"
find /backup -mindepth 1 -maxdepth 1 -type f -ctime +30 -exec rm -r {} \;