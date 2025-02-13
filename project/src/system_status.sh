#!/bin/bash

echo "Загрузка процессора:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU загружен на " 100 - $1 "%"}'

echo "Использование памяти:"
free -h | grep Mem | awk '{print "Использовано памяти: " $3 " из " $2}'

echo "Свободное место на диске:"
df -h | grep '^/dev/' | awk '{print $1 ": " $4 " свободно из " $2}'
