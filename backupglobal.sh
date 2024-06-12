#!/bin/bash
#

# Source directory
SOURCE="/home/vpn/gitrepo/scripts"

# Destination directory
DESTINATION="/home/vpn/backups"

# Current date
DATE=$(date +%y-%m-%d)

# Backup file name
BACKUP_NAME="backup-$DATE.tar.gz"

# Log file
LOG_FILE="/var/log/scriptbackup.log"

# Function to send email notifications
send_notification() {
    echo "Subject: Backup Completed" | sendmail -v adalsanto@outlook.es
}

# Create the backup and log the output
{
    echo "Starting backup: $(date)"
    
    # Using rsync to synchronize the files
    rsync -av --delete $SOURCE $DESTINATION
    
    if [ $? -eq 0 ]; then
        echo "Rsync completed successfully"
        
        # Creating a compressed archive of the synchronized directory
        tar -czvf $DESTINATION/$BACKUP_NAME -C $DESTINATION .
        
        if [ $? -eq 0 ]; then
            echo "Backup completed successfully: $DESTINATION/$BACKUP_NAME"
            send_notification
        else
            echo "Error during tar creation"
        fi
    else
        echo "Error during rsync"
    fi
    
    echo "Finished: $(date)"
} 2>&1 | tee -a $LOG_FILE
