#Upload to OneDrive
#!/bin/bash
export SERVER_NAME=SRV-SN-12.179
export RCLONE="/usr/sbin/rclone"
export TIMESTAMP=$(date +"%F")
export BACKUP_DIR="/backup/$TIMESTAMP"
echo "Starting Backup Data"
cd $BACKUP_DIR
pwd
for FILE in *; do echo "backup $FILE" && $RCLONE move $FILE "drive:$SERVER_NAME/$TIMESTAMP/backup" ; done
echo "Finished all backup"

# Clean up
rm -rf $BACKUP_DIR
$RCLONE -q --min-age 12M delete "drive:$SERVER_NAME" #Remove all backups older than 2 month
$RCLONE -q --min-age 12M rmdirs "drive:$SERVER_NAME" #Remove all empty folders older than 2 month

$RCLONE cleanup "drive:" #Cleanup Trash

echo "Finished cleanup"

exit