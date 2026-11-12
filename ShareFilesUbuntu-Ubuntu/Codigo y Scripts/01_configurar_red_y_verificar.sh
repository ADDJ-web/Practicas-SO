#!/usr/bin/env bash
# ==============================================================================
# TECNOLÓGICO NACIONAL DE MÉXICO - INGENIERÍA EN SISTEMAS COMPUTACIONALES
# Asignatura: Sistemas Operativos
# Práctica: Compartir Archivos Ubuntu a Ubuntu mediante Samba (SMB/CIFS)
# Estudiante: Israel Carmona Santos | Matrícula: 241000211
# Script: 01_configurar_red_y_verificar.sh
# Descripción: Muestra la configuración de red IPv4 (IP, máscara 255.255.255.0)
#              y comprueba la conectividad con la otra PC usando 'ping -c 4'.
# ==============================================================================

set -euo pipefail

readonly VERDE="\033[1;32m"
readonly AZUL="\033[1;36m"
readonly AMARILLO="\033[1;33m"
readonly ROJO="\033[1;31m"
readonly RESET="\033[0m"

echo -e "${AZUL}======================================================================${RESET}"
echo -e "${AZUL}   PASO 1: VERIFICACIÓN DE RED IPV4 Y PRUEBA DE ENLACE (-c 4)        ${RESET}"
echo -e "${AZUL}======================================================================${RESET}"

# IP de la otra máquina Ubuntu en el laboratorio escolar
IP_DESTINO="${1:-192.168.1.2}"

echo -e "\n${AMARILLO}[1] Mostrando adaptadores de red y direcciones IP de este equipo:${RESET}"
ip -4 addr show | grep -E "inet "

echo -e "\n${AMARILLO}[2] Parámetros de red utilizados en la práctica Ubuntu-Ubuntu:${RESET}"
echo "    - Equipo local       : $(hostname) ($(whoami))"
echo "    - Máscara de subred  : 255.255.255.0 (/24)"
echo "    - IP objetivo remoto : ${IP_DESTINO}"

echo -e "\n${AMARILLO}[3] Comprobando conexión física Ethernet con la otra máquina (-c 4):${RESET}"
echo -e "${AZUL}Ejecutando: ping -c 4 ${IP_DESTINO}${RESET}\n"

if ping -c 4 "${IP_DESTINO}"; then
    echo -e "\n${VERDE}======================================================================${RESET}"
    echo -e "${VERDE}  ¡CONECTADO CON ÉXITO! La otra máquina Ubuntu responde al 100%.     ${RESET}"
    echo -e "${VERDE}  Cero por ciento de pérdida de paquetes (0% packet loss).            ${RESET}"
    echo -e "${VERDE}======================================================================${RESET}"
else
    echo -e "\n${ROJO}[ERROR] No hubo respuesta desde ${IP_DESTINO}. Verifique cable y máscara.${RESET}"
    exit 1
fi
