#!/bin/bash

SITE="google.com"

ping -c 4 $SITE > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "$SITE доступен."
else
    echo "$SITE не доступен."
fi
