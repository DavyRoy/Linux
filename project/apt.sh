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
