#!/usr/bin/env bash
# ==============================================================================
# TECNOLÓGICO NACIONAL DE MÉXICO - INGENIERÍA EN SISTEMAS COMPUTACIONALES
# Asignatura: Sistemas Operativos
# Práctica: Compartir Archivos Ubuntu a Ubuntu mediante Samba (SMB/CIFS)
# Estudiante: Israel Carmona Santos | Matrícula: 241000211
# Script: 03_probar_transferencia.sh
# ==============================================================================

set -euo pipefail

readonly VERDE="\033[1;32m"
readonly AZUL="\033[1;36m"
readonly AMARILLO="\033[1;33m"
readonly RESET="\033[0m"

USUARIO="${USER}"
CARPETA_COMPARTIDA="${HOME}/Escritorio/IsrAMBA/1"

echo -e "${AZUL}======================================================================${RESET}"
echo -e "${AZUL}     PASO 3: PRUEBA DE ARCHIVO COMPARTIDO EN RED UBUNTU-UBUNTU        ${RESET}"
echo -e "${AZUL}======================================================================${RESET}"

mkdir -p "${CARPETA_COMPARTIDA}"
ARCHIVO="${CARPETA_COMPARTIDA}/prueba_ubuntu_ubuntu.txt"

echo -e "\n${AMARILLO}[1] Generando archivo de prueba en la carpeta compartida...${RESET}"
cat << EOF > "${ARCHIVO}"
==============================================================================
TECNOLOGICO NACIONAL DE MEXICO - PRACTICA DE SISTEMAS OPERATIVOS
Transferencia de Archivos en Red Local: Ubuntu a Ubuntu con Samba
Estudiante: Israel Carmona Santos (Matricula: 241000211)
Equipo Emisor: $(hostname)
Fecha y Hora: $(date)
Ubicacion: Escritorio/IsrAMBA/1/prueba_ubuntu_ubuntu.txt
==============================================================================
Este archivo confirma que la comunicacion de red local y el protocolo SMB
permiten compartir datos de manera transparente e instantanea entre dos
equipos con el sistema operativo Ubuntu Linux.
EOF

echo -e "${VERDE}[OK] Archivo generado en: ${ARCHIVO}${RESET}"

echo -e "\n${AMARILLO}[2] Generando huella digital de integridad SHA-256:${RESET}"
HASH=$(sha256sum "${ARCHIVO}" | awk '{print $1}')
echo -e "${AZUL}SHA-256:${RESET} ${HASH}"

echo -e "\n${AMARILLO}[3] Listando elementos en la carpeta compartida IsrAMBA/1:${RESET}"
ls -lh "${CARPETA_COMPARTIDA}"

echo -e "\n${VERDE}======================================================================${RESET}"
echo -e "${VERDE}  ¡ARCHIVO LISTO PARA ACCEDER DESDE LA OTRA MÁQUINA UBUNTU!          ${RESET}"
echo -e "${VERDE}======================================================================${RESET}\n"
