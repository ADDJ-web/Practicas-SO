#!/usr/bin/env bash
# ==============================================================================
# TECNOLÓGICO NACIONAL DE MÉXICO - INGENIERÍA EN SISTEMAS COMPUTACIONALES
# Asignatura: Sistemas Operativos
# Práctica: Compartir Archivos Ubuntu a Ubuntu mediante Samba (SMB/CIFS)
# Estudiante: Israel Carmona Santos | Matrícula: 241000211
# Script: 02_instalar_samba_y_crear_usuario.sh
# Descripción: Instala Samba en Ubuntu, crea la carpeta 'Escritorio/IsrAMBA',
#              asigna permisos 777, crea el usuario con smbpasswd -a
#              y reinicia el servicio para compartir con el otro Ubuntu.
# ==============================================================================

set -euo pipefail

readonly VERDE="\033[1;32m"
readonly AZUL="\033[1;36m"
readonly AMARILLO="\033[1;33m"
readonly ROJO="\033[1;31m"
readonly RESET="\033[0m"

echo -e "${AZUL}======================================================================${RESET}"
echo -e "${AZUL}     PASO 2: INSTALACIÓN DE SAMBA Y CREACIÓN DE USUARIO DE RED        ${RESET}"
echo -e "${AZUL}======================================================================${RESET}"

if [[ $EUID -ne 0 ]]; then
    echo -e "${ROJO}[ERROR] Este script debe ejecutarse con permisos de administrador.${RESET}"
    echo "Por favor ejecute: sudo $0"
    exit 1
fi

USUARIO="${SUDO_USER:-$USER}"
CARPETA="/home/${USUARIO}/Escritorio/IsrAMBA"

echo -e "\n${AMARILLO}[1/5] Instalando Samba en Ubuntu...${RESET}"
apt-get update -y > /dev/null
apt-get install -y samba > /dev/null
echo -e "${VERDE}[OK] Paquete Samba instalado correctamente.${RESET}"

echo -e "\n${AMARILLO}[2/5] Creando la carpeta compartida en el Escritorio...${RESET}"
mkdir -p "${CARPETA}"
mkdir -p "${CARPETA}/1"
chown -R "${USUARIO}:${USUARIO}" "${CARPETA}"
chmod -R 777 "${CARPETA}"
echo -e "${VERDE}[OK] Carpeta creada en: ${CARPETA} con permisos 777.${RESET}"

echo -e "\n${AMARILLO}[3/5] Configurando el recurso [IsrAMBA] en /etc/samba/smb.conf...${RESET}"
sed -i "/\\[IsrAMBA\\]/,/^$/d" /etc/samba/smb.conf

cat << EOF >> /etc/samba/smb.conf

[IsrAMBA]
   comment = Carpeta Compartida Ubuntu a Ubuntu - Israel Carmona
   path = ${CARPETA}
   browseable = yes
   read only = no
   create mask = 0777
   directory mask = 0777
   valid users = ${USUARIO}
EOF
echo -e "${VERDE}[OK] Recurso [IsrAMBA] registrado en smb.conf.${RESET}"

echo -e "\n${AMARILLO}[4/5] Creando credenciales de Samba para el usuario: ${USUARIO}${RESET}"
echo "Ingrese la contraseña que usará para conectar desde el otro equipo Ubuntu:"
smbpasswd -a "${USUARIO}"

echo -e "\n${AMARILLO}[5/5] Reiniciando el demonio smbd de Samba...${RESET}"
systemctl restart smbd
systemctl enable smbd > /dev/null 2>&1
echo -e "${VERDE}[OK] Servicio smbd activo y en ejecución.${RESET}"

MI_IP=$(hostname -I | awk '{print $1}')
echo -e "\n${VERDE}======================================================================${RESET}"
echo -e "${VERDE}  ¡SAMBA LISTO PARA COMPARTIR ENTRE EQUIPOS UBUNTU!                   ${RESET}"
echo -e "${VERDE}======================================================================${RESET}"
echo -e "${AZUL}Dirección IP del Servidor:${RESET} ${MI_IP}"
echo -e "${AZUL}Usuario de Red:${RESET}           ${USUARIO}"
echo -e "\n${AMARILLO}Cómo conectarte desde el otro equipo con Ubuntu:${RESET}"
echo "1. Abre el gestor de archivos 'Archivos' (Nautilus)."
echo "2. En la barra lateral selecciona 'Otras ubicaciones' o 'Red'."
echo "3. En el campo 'Conectar al servidor' escribe:"
echo -e "   ${VERDE}smb://${MI_IP}/${RESET}"
echo "4. Ingresa el usuario (${USUARIO}) y la contraseña creada."
echo "5. Verás el recurso 'IsrAMBA' con la carpeta '1' para intercambiar archivos."
echo -e "${AZUL}======================================================================${RESET}\n"
