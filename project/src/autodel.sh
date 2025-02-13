#!/bin/bash

find /tmp -type f -mtime +7 -exec rm -f {} \;

echo "Очистка временных файлов завершена."
