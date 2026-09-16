#!/usr/bin/env bash
# ==============================================================================
# Script: practica_archivos_permisos.sh
# Descripción: Reproducción automatizada de la práctica de gestión de archivos,
#              directorios, transferencias y permisos POSIX en Linux.
# ==============================================================================

# Detiene la ejecución si ocurre un error inesperado
set -e

# Definición del directorio base de trabajo
WORK_DIR="$HOME/Documentos"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# ------------------------------------------------------------------------------
# PARTE 1: Creación de estructura inicial y archivo con privilegios root
# ------------------------------------------------------------------------------

# Creación de los directorios de trabajo principales
mkdir -p practica1 practica2
ls -l

# Acceso al directorio practica1
cd practica1

# Creación interactiva del archivo 'Readme.txt' con privilegios de superusuario (root)
# Nota: Al usar sudo, el archivo pertenecerá a root:root con permisos restrictivos (ej. 644)
sudo nano Readme.txt

# Verificación de metadatos (propietario, grupo y permisos del archivo recién creado)
ls -l

# Copia verbal del archivo Readme.txt hacia practica2
# Nota: La copia conserva el contenido, pero asume el propietario del usuario ejecutor
cp -v Readme.txt "$WORK_DIR/practica2/"

# ------------------------------------------------------------------------------
# PARTE 2: Subdirectorios, creación anidada y replicación recursiva
# ------------------------------------------------------------------------------

# Navegación hacia practica2
cd "$WORK_DIR/practica2"

# Creación de estructura interna de carpetas
mkdir -p vacia info
ls -l

# Creación interactiva de un archivo secundario dentro del subdirectorio 'info'
sudo nano info/Readme2.txt

# Copia recursiva y detallada (-r -v) de directorios hacia practica1
cp -v -r vacia ../practica1
cp -v -r info ../practica1

# Retorno a practica1 y verificación del estado sincronizado
cd "$WORK_DIR/practica1"
ls -l

# ------------------------------------------------------------------------------
# PARTE 3: Eliminación, evaluación de permisos DAC y estado final
# ------------------------------------------------------------------------------

# Eliminación de Readme.txt
# Nota: Como el archivo pertenece a root (0644) pero el directorio pertenece al
# usuario estándar con permisos de escritura (w), rm solicitará confirmación (s/n).
rm Readme.txt

# Eliminación recursiva y verbal (-r -v) del directorio no vacío 'info/'
rm -r -v info/

# Verificación del estado final del directorio (únicamente debe persistir 'vacia')
ls -l