#Upload to Google Drive
#!/bin/bash
SERVER_NAME=SN-179
RCLONE="/usr/sbin/rclone"
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
echo "Starting Backup Data"
mkdir -p "$BACKUP_DIR/data"
zip -r "$BACKUP_DIR/data/data.zip" "/backup"
$RCLONE move $BACKUP_DIR/data/data.zip "drive:$SERVER_NAME/$TIMESTAMP/data"
echo "Finished"
echo ''
# Clean up
rm -rf $BACKUP_DIR
$RCLONE -q --min-age 12M delete "drive:$SERVER_NAME" #Remove all backups older than 2 month
$RCLONE -q --min-age 12M rmdirs "drive:$SERVER_NAME" #Remove all empty folders older than 2 month
$RCLONE cleanup "drive:" #Cleanup Trash
echo "Finished"
find /backup -mindepth 1 -maxdepth 1 -type f -ctime +30 -exec rm -r {} \;