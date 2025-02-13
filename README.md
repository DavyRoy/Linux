# Linux

---

### Задание 1 - Введение в Linux и работа с командной строкой

1. `Создай структуру каталогов с минимум 3 уровнями (например, project/{src,bin,docs/{images,notes}}).`
2. `Помести в эти каталоги несколько файлов (например, .txt, .c, .md).`
3. `Выполни следующие операции: Скопируй один файл из одного каталога в другой.Переименуй файл. Удали файл и каталог`

``` ~Решение~
1.
mkdir devops
cd devops
mkdir Linux
cd Linux
mkdir -p project/{src,bin,docs/{images,notes}}
touch /home/sergey/devops/Linux/project/docs/file.txt
touch /home/sergey/devops/Linux/project/docs/file1.c
touch /home/sergey/devops/Linux/project/docs/file2.md
2.
cp ~/devops/Linux/project/docs/file.txt ~/devops/Linux/project/bin/
cp ~/devops/Linux/project/docs/file1.c ~/devops/Linux/project/docs/notes/
cp ~/devops/Linux/project/docs/file2.md ~/devops/Linux/project/src/
3.
mv ~/devops/Linux/project/src/file2.md ~/devops/Linux/project/src/readme.md
mv ~/devops/Linux/project/bin/file.txt ~/devops/Linux/project/bin/guide.txt
mv ~/devops/Linux/project/docs/notes/file1.c ~/devops/Linux/project/docs/notes/main.c
rm ~/devops/Linux/project/src/readme.md
rm -r ~/devops/Linux/project/src/
mkdir ~/devops/Linux/project/src/
....
│   └── project
│       ├── bin
│       │   └── guide.txt
│       ├── docs
│       │   ├── file1.c
│       │   ├── file2.md
│       │   ├── file.txt
│       │   ├── images
│       │   └── notes
│       │       └── main.c
│       └── src
....
```

`Cкриншоты
![Cкриншот 1](ссылка на скриншот 1)`

---

### Задание 2 - Управление пользователями и правами доступа в Linux

1. `Создай 3 пользователей: admin1, dev1, dev2.`
2. `Создай 2 группы: admins, developers.`
3. `Добавь admin1 в admins, а dev1 и dev2 в developers.`
4. `Создай директорию /projects/ и файл /projects/code.py.`
5. `Дай admin1 полный доступ (rwx), developers – только rw, остальным – запрети доступ.`

``` ~Решение~
1.
sudo useradd -m admin1
sudo useradd -m dev1
sudo useradd -m dev2 
2.
sudo groupadd admins
sudo groupadd developers
3.
sudo usermod -aG admins admin1
sudo usermod -aG developers dev1
sudo usermod -aG developers dev2
4.
mkdir projects
touch ~/devops/Linux/projects/code.py
5.
sudo chown -R admin1:admins /home/sergey/devops/Linux/projects
sudo chmod 770 /home/sergey/devops/Linux/projects
sudo setfacl -m g:developers:rw /home/sergey/devops/Linux/projects
getfacl /home/sergey/devops/Linux/projects
....
# file: home/sergey/devops/Linux/projects
# owner: admin1
# group: admins
user::rwx
group::rwx
group:developers:rw-
mask::rwx
other::---
....
```

`Cкриншоты
![Cкриншот 2](ссылка на скриншот 2)`

---

### Задание 3 - Установка и управление пакетами

1. `Создай скрипт, который будет устанавливать несколько приложений (например, curl, vim и git).`
2. `Запусти его на своей системе и проверь, что все приложения установлены.`

``` ~Решение~
1.
touch /home/sergey/devops/Linux/project/apt.sh
nano apt.sh
chmod +x apt.sh
2.
. apt.sh
....
#!/bin/bash

# Обновляем индексы репозиториев
echo "Обновляем индексы пакетов..."
sudo apt update

# Устанавливаем пакеты
echo "Устанавливаем curl, vim и git..."
sudo apt install -y curl vim git

# Проверяем, что пакеты установлены
echo "Проверяем установленные пакеты..."
curl --version
vim --version
git --version
....
```

`Cкриншоты
![Cкриншот ](ссылка на скриншот)`

---

### Задание 4 - Процессы и управление ими

1. `Запусти несколько процессов на своей машине (например, редактор, браузер и терминал).`
2. `Используя команду ps aux, найди процессы, относящиеся к firefox. Отметь их PID.`
3. `Заверши один из процессов с помощью kill.`
4. `Используй команду nice для запуска процесса с изменённым приоритетом. Проверь это с помощью top.`
5. `Напиши небольшой отчет о том, как ты использовал эти команды для отслеживания и завершения процессов.`

``` ~Решение~
2.
ps aux | grep firefox - запустил вывод всех процессов по имени 
3.
kill -9 94347 - убил(принудительно завершил) процесс по pid 
pkill  firefox - убил процесс по имени
4.
nice -n -10 top - запустил процесс с высоким приоритетом 

```

`Скриншоты
![Скриншот ](ссылка на скриншот)`

---

### Задание 5 - Сетевые настройки

1. `Настрой SSH на сервере: Установи SSH-сервер, настрой его безопасность (смена порта, отключение пароля) и подключись к серверу с другого компьютера.`
2. `Настрой статический IP: На своем сервере настрой статический IP-адрес.`

``` ~Решение~
1.
sudo apt install openssh-server
sudo systemctl status ssh
ssh root_test@192.168.1.2
sudo nano /etc/ssh/sshd_config
Port 2233
ssh-keygen -t rsa -b 4096
ssh-copy-id oot_test@192.168.1.2
2.
nano /etc/ssh/sshd_config - PasswordAuthentication no
sudo systemctl restart ssh
sudo nano /etc/network/interfaces    
....
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1

....
sudo systemctl restart networking
....
```

`Cкриншоты
![Cкриншот 1](ссылка на скриншот 1)`

---

### Задание 6 - Логи и диагностика системы в Linux

1. `Провести анализа логов`
2. `Создай отчет, где ты: Опишешь, какие логи проверял. Найдешь и объяснишь причины ошибок в этих логах. Описал, какие меры предпринял для исправления найденных ошибок.`

``` ~Решение~
1.
journalctl - ERROR: Unable to connect to MySQL database
2.
   Отчет по диагностике ошибки:
      Нашел следующее сообщение в логе **`syslog`**
   Описание проблемы:
      Причина ошибки заключается в том, что служба MySQL не смогла подключиться к базе данных. 
      Я просмотрел более детальные логи с помощью команды: 
         sudo cat /var/log/mysql/error.log - Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock'
   Решение:
      Я перезапустил службу MySQL с помощью команды:  
         sudo systemctl restart mysql
      Проблема была связана с тем, что сокет MySQL был заблокирован. Я перезапустил сервис, и все вернулось в норму.
....
```

`Cкриншоты
![Cкриншот 2](ссылка на скриншот 2)`

---

### Задание 7 - Автоматизация задач с помощью cron

1. `Напиши скрипт, который выполняет регулярную задачу (например, резервное копирование, проверка состояния системы docker и обновление пакетов).`
2. `Создай задание cron, чтобы этот скрипт выполнялся через определённый промежуток времени (например, раз в сутки, каждое каждое утро во вторник в 2:00).`

``` ~Решение~
1.
....
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
....
2.
0 2 * * 2 /home/sergey/devops/Linux/project/script.sh
....
```

`Cкриншоты
![Cкриншот ](ссылка на скриншот)`

---

### Задание 8 - Основы Bash-скриптов

1. `Напиши bash-скрипт для автоматизации одной из повседневных задач на твоей машине. 1.1 Резервное копирование важных файлов или папок. 1.2 Автоматическое обновление системы 1.3 Очистка временных файлов и кэша. 1.4 Настройка и мониторинг сервиса. 1.5 Печать текущего состояния системы (например, загрузки процессора, памяти, диска).1.6 Проверка доступности серверов или сайтов.`


``` ~Решение~
1.1.
#!/bin/bash

SOURCE_DIR="/home/sergey/devops/"
BACKUP_DIR="/home/sergey/devops_backup_script/"
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

tar -czf $BACKUP_FILE $SOURCE_DIR
echo "Резервное копирование завершено: $BACKUP_FILE"
....
1.2
#!/bin/bash

echo "Обновление системы..."
apt update -y
apt upgrade -y
apt autoremove -y

echo "Перезагрузка системы..."
reboot
....
1.3.
#!/bin/bash

find /tmp -type f -mtime +7 -exec rm -f {} \;

echo "Очистка временных файлов завершена."
....
1.4.
#!/bin/bash

SERVICE="nginx"

systemctl is-active --quiet $SERVICE
if [ $? != 0 ]; then
    echo "$SERVICE не запущен. Перезапуск..."
    systemctl restart $SERVICE
    echo "$SERVICE перезапущен."
else
    echo "$SERVICE работает нормально."
fi
....
1.5
#!/bin/bash

echo "Загрузка процессора:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU загружен на " 100 - $1 "%"}'

echo "Использование памяти:"
free -h | grep Mem | awk '{print "Использовано памяти: " $3 " из " $2}'

echo "Свободное место на диске:"
df -h | grep '^/dev/' | awk '{print $1 ": " $4 " свободно из " $2}'
....
1.6
#!/bin/bash

SITE="google.com"

ping -c 4 $SITE > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "$SITE доступен."
else
    echo "$SITE не доступен."
fi
....
nano /home/sergey/devops/Linux/project/src/backup.sh
nano /home/sergey/devops/Linux/project/src/autoapdate.sh
nano /home/sergey/devops/Linux/project/src/autodel.sh
nano /home/sergey/devops/Linux/project/src/monitor_service.sh
nano /home/sergey/devops/Linux/project/src/system_status.sh
nano /home/sergey/devops/Linux/project/src/check_site.sh
chmod +x backup.sh
chmod +x autoapdate.sh
chmod +x autodel.sh
chmod +x monitor_service.sh
chmod +x system_status.sh
chmod +x check_site.sh
./backup.sh
./autoapdate.sh
./autodel.sh
./monitor_service.sh
./system_status.sh
./check_site.sh
....
```

`Скриншоты
![Скриншот ](ссылка на скриншот)`

---

### Задание 9 - Система безопасности Linux

1. `Ограничить доступ к серверу для определенных пользователей`
2. `Ограничить доступ к серверу для определенных пользователей`

``` ~Решение~
1.
nano /etc/ssh/sshd_config
   AllowUsers admin devops
   DenyUsers hacker
sudo systemctl restart sshd
2.
sudo apt install auditd -y
sudo auditctl -w /etc/passwd -p wa -k passwd_changes
sudo ausearch -k passwd_changes
....
```

`Cкриншоты
![Cкриншот ](ссылка на скриншот)`

---

### Задание 10 - Мониторинг и оптимизация в Linux

1. `Установить Prometheus и Node Exporter.`
2. `Проверить, собираются ли метрики`

``` ~Решение~
1.
sudo useradd --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-linux-amd64.tar.gz
tar xvf prometheus-linux-amd64.tar.gz
cd prometheus-*
sudo mv prometheus /usr/local/bin/
sudo mv promtool /usr/local/bin/
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo nano /etc/prometheus/prometheus.yml
   global:
      scrape_interval: 15s
   scrape_configs:
      - job_name: 'node'
        static_configs:
            - targets: ['localhost:8080']
sudo nano /etc/systemd/system/prometheus.service
   [Unit]
   Description=Prometheus
   After=network.target

   [Service]
   User=prometheus
   ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/
   Restart=always

   [Install]
   WantedBy=multi-user.target
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
....
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-linux-amd64.tar.gz
tar xvf node_exporter-linux-amd64.tar.gz
sudo mv node_exporter-* /usr/local/bin/node_exporter
sudo nano /etc/systemd/system/node_exporter.service
   [Unit]
   Description=Node Exporter
   After=network.target

   [Service]
   User=root
   ExecStart=/usr/local/bin/node_exporter

   [Install]
   WantedBy=default.target
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
....
```

`Скриншоты
![Скриншот ](ссылка на скриншот)`

---