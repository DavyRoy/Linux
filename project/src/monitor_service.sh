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
