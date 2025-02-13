#!/bin/bash

SOURCE_DIR="/home/sergey/devops/"
BACKUP_DIR="/home/sergey/devops_backup_script/"
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

tar -czf $BACKUP_FILE $SOURCE_DIR
echo "Резервное копирование завершено: $BACKUP_FILE"
