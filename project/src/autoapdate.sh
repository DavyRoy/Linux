#!/bin/bash

echo "Обновление системы..."
apt update -y
apt upgrade -y
apt autoremove -y

echo "Перезагрузка системы..."
reboot
