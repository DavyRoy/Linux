#!/bin/bash

# Параметры
BACKUP_DIR="/backups"
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/postgres_backup_$DATE.sql"

# Выполнение резервного копирования
docker exec postgres pg_dump -U user mydb > $BACKUP_FILE

# Проверка результата
if [ $? -eq 0 ]; then
  echo "Резервное копирование выполнено успешно: $BACKUP_FILE"
else
  echo "Ошибка при выполнении резервного копирования."
fi
