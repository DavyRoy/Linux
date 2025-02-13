# Linux - Итог

---

### Задание - Мини-система на Linux

1. `Создание веб-сервера с базой данных`
2. `Настройка мониторинга`
3. `Резервное копирование`
4. `Интеграция через Docker`

``` ~Решение~
1.
mmkdir nginx
mkdir postgreSQL
mkdir prometheus
nano docker-compose.yml
   version: '3.7'

services:
  web:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    networks:
      - webnet

  db:
    image: postgres:latest
    container_name: postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - webnet

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
    networks:
      - webnet

  node_exporter:
    image: prom/node-exporter:latest
    container_name: node_exporter
    networks:
      - webnet

volumes:
  pg_data:

networks:
  webnet:
    driver: bridge
2.
nano /home/sergey/devops/Linux/linux-end/nginx/nginx.conf 
   user nginx;
worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    server {
        listen       80;
        server_name  localhost;

        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
    }
}
nano /home/sergey/devops/Linux/linux-end/prometheus/prometheus.yml
   global:
  scrape_interval: 15s

   scrape_configs:
      - job_name: 'nginx'
        static_configs:
         - targets: ['nginx:80']

      - job_name: 'node_exporter'
        static_configs:
         - targets: ['node_exporter:9100']
nano backup.sh
   #!/bin/bash

   BACKUP_DIR="/backups"
   DATE=$(date +%F)
   BACKUP_FILE="$BACKUP_DIR/postgres_backup_$DATE.sql"

   docker exec postgres pg_dump -U user mydb > $BACKUP_FILE

   if [ $? -eq 0 ]; then
      echo "Резервное копирование выполнено успешно: $BACKUP_FILE"
   else
      echo "Ошибка при выполнении резервного копирования."
   fi
3.
docker-compose up -d
crontab -e
docker ps 

9e2f012e714c  nginx:latest  Up 10 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp nginx
960f54c40fa1  prom/node-exporter:latest  Up 16 minutes   9100/tcp  node_exporter
e36317b407d8 postgres:latest  Up 16 minutes   5432/tcp  postgres
cbd5ce82e42f  prom/prometheus:latest  Up 16 minutes   0.0.0.0:9090->9090/tcp, :::9090->9090/tcp prometheus
....
```

`Cкриншоты
![Cкриншот 1](ссылка на скриншот 1)`

---
