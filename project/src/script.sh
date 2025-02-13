#!/bin/bash

# Директория, которую нужно копировать
SOURCE_DIR="/home/sergey/devops/"

# Директория для хранения резервных копий
BACKUP_DIR="home/sergey/devops-backup/"

# Создание резервной копии
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

tar -czf $BACKUP_FILE $SOURCE_DIR

echo "Резервное копирование завершено: $BACKUP_FILE"

# Проверка состояния службы
systemctl status apache2
echo "Проверка службы apache2 выполнена"

# Обновление системы
apt update -y
apt upgrade -y
echo "Обновление системы завершено"
