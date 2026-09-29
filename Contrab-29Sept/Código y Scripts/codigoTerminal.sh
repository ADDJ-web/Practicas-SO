mkdir -p ~/salud_pc

nano ~/salud_pc/monitor.sh

# En nano, se escribirá todo esto.

#!/bin/bash
# FECHA=$(date '+%Y-%m-%d %H:%M:%S')
# HOST=$(hostname)
#
# CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
# RAM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
# DISCO=$(df -h / | awk 'NR==2 {print $5}')
# UPTIME=$(uptime -p)
#
# {
#     echo "========================================"
#     echo "Fecha: $FECHA"
#     echo "Equipo: $HOST"
#     echo "Uso de CPU: ${CPU}%"
#     echo "Uso de RAM: $RAM"
#     echo "Uso del disco: $DISCO"
#     echo "Tiempo encendido: $UPTIME"
#     echo "========================================"
#     echo
# } >> ~/salud_pc/salud.log

chmod +x ~/salud_pc/monitor.sh

# ~/salud_pc/monitor.sh para probar manualmente

# cat ~/salud_pc/salud.log comprobar el resultado

crontab -e

# Al final del archivo de contrab, se agrega: */2 * * * * /home/teemuntu/salud_pc/monitor.sh

crontab -l
