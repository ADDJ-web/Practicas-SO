#!/bin/bash

#1. Crear y editar el script de monitoreo en la ruta de binarios locales

sudo nano /usr/local/bin/monitor-salud.sh

# 2. Modificar los permisos para hacerlo ejecutable, mostrando los cambios (-v)

sudo chmod +x -v /usr/local/bin/monitor-salud.sh

# 3. Prueba manual del script para verificar su salida (se detuvo con Ctrl+C en tu terminal)

/usr/local/bin/monitor-salud.sh

# 4. Crear y editar el archivo de unidad del servicio para systemd

sudo nano /etc/systemd/system/monitor-salud.service

# 5. Recargar la configuración del supervisor systemd en memoria

sudo systemctl daemon-reload

# 6. Iniciar el demonio por primera vez

sudo systemctl start monitor-salud.service

# 7. Consultar el estado del servicio para verificar que esté "active (running)" y obtener su Main PID

systemctl status monitor-salud.service

# 8. Habilitar el servicio (creación del enlace simbólico) para que sobreviva a los reinicios del sistema

sudo systemctl enable monitor-salud.service

# 9. Enviar la señal de terminación forzada (SIGKILL) al PID principal del demonio.

# Nota: El PID (7868 en tu captura) será dinámico y diferente en cada ejecución.

sudo kill -9 7868

# 10. Consultar el estado inmediatamente para capturar el momento de recuperación "activating (auto-restart)"

systemctl status monitor-salud.service

# 11. Volver a consultar el estado para confirmar la recuperación exitosa con el nuevo PID (7997 en tu captura)

systemctl status monitor-salud.service
