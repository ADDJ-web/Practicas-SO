#!/bin/bash

while true
do
    FECHA=$(date '+%Y-%m-%d %H:%M:%S')
    PROCESOS=$(ps -e --no-headers | wc -l)
    RAM=$(free -h | awk '/Mem:/ {print $7}')

    echo "Fecha: $FECHA | Procesos activos: $PROCESOS | RAM disponible: $RAM"

    sleep 5
done
