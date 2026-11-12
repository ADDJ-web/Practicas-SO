# 🐧🐧 ShareFilesUbuntu-Ubuntu

### Compartición e Interoperabilidad de Archivos entre Equipos Ubuntu Linux en Red Local mediante Samba (SMB/CIFS)

Implementación, automatización y documentación técnica para la interconexión física y lógica mediante protocolo **SMB/CIFS (Samba)** entre dos equipos con sistema operativo **Ubuntu Linux** en una red local aislada.

## 🎥 Video Demostrativo

> 🔗 **Enlace directo al video:** <https://youtu.be/211c6FQa2oo>
>
> *(Demostración práctica donde se observa la conexión física entre dos equipos con Ubuntu, la verificación de enlace con el comando `ping -c 4`, la configuración del servidor Samba y la navegación en Nautilus hacia el recurso compartido).*

## 📁 Estructura del Repositorio

El proyecto está organizado siguiendo exactamente la jerarquía de directorios de **`ShareFilesUbuntu-Ubuntu`**:

| Carpeta | Descripción y Contenido | Enlace Directo | 
| ----- | ----- | ----- | 
| 💻 **Código y Scripts** | Scripts en Bash limpios, funcionales y comentados para configurar la red y el servidor Samba. | [Ver carpeta `Codigo y Scripts/`](Codigo%20y%20Scripts/) | 
| 📑 **Reporte** | Documentación técnica en formato PDF y editable con el análisis teórico y arquitectura del sistema. | [Ver carpeta `Reporte/`](Reporte/) | 
| 📸 **Terminal** | Capturas nítidas, evidencias gráficas y registro íntegro de los comandos ejecutados en consola. | [Ver carpeta `Terminal/`](Terminal/) | 
| 🎬 **Video** | Recursos multimedia, guión técnico y material de apoyo de la demostración en vivo. | [Ver carpeta `Video/`](Video/) | 

## 🖼️ Galería de Evidencias (Entorno de Pruebas)

| Evidencia | Descripción Técnica | Enlace en `Terminal/` | 
| ----- | ----- | ----- | 
| **Evidencia 1: Ping y Comparticiones** | Equipo 1 con terminal ejecutando `ping -c 4 192.168.1.2` (0% packet loss) y Nautilus en `Comparticiones de red en 192.168.1.2` mostrando el recurso compartido. | [01_ping_y_comparticiones_nautilus.jpg](Terminal/01_ping_y_comparticiones_nautilus.jpg) | 
| **Evidencia 2: Carpeta y Ping Cliente** | Equipo cliente con la carpeta compartida en el Escritorio y terminal con `ping -c 4 192.168.1.7` conectado. | [02_escritorio_share_y_ping_cliente.jpg](Terminal/02_escritorio_share_y_ping_cliente.jpg) | 
| **Evidencia 3: Conexión Activa Carpeta 1** | Detalle de acceso dentro del recurso compartido en `192.168.1.2` mostrando la carpeta de destino `1`. | [03_conexion_share_carpeta1.jpg](Terminal/03_conexion_share_carpeta1.jpg) | 
| **Registro de Comandos** | Transcripción íntegra de la sesión de terminal en texto plano. | [Comandos_Terminal_Completos.txt](Terminal/Comandos_Terminal_Completos.txt) | 

## 🎯 1. Resumen y Propósito del Proyecto

El objetivo de esta implementación es interconectar físicamente mediante cable Ethernet y configurar lógicamente dos equipos ejecutando **Ubuntu Linux** para compartir directorios y transferir archivos en tiempo real mediante el protocolo **SMB/CIFS (Samba)**, sin depender de conexión a Internet ni routers comerciales.

### Flujo de Configuración Realizado:

1. **Configuración de Red IPv4 Manual:** En los ajustes de red de ambos equipos se asignaron direcciones IP estáticas en el segmento local (`192.168.1.2` y `192.168.1.7`), utilizando la máscara de subred `255.255.255.0` (`/24`).
2. **Comprobación de Enlace Bidireccional con `-c`:**
   * En el equipo 1 se ejecutó `ping -c 4 192.168.1.2`, confirmando 4 paquetes recibidos y 0% de pérdida de paquetes.
   * En el equipo 2 se ejecutó `ping -c 4 192.168.1.7`, confirmando 4 paquetes recibidos y 0% de pérdida de paquetes.
3. **Instalación y Despliegue de Samba:** Se instaló el paquete `samba` en el equipo servidor, se declaró el directorio compartido con permisos `777` en `/etc/samba/smb.conf` y se dio de alta el usuario de red mediante `sudo smbpasswd -a <usuario>`.
4. **Navegación y Transferencia en Nautilus (GVfs):** En el equipo cliente se abrió el explorador de archivos Nautilus, se ingresó en *Conectar al servidor* la dirección `smb://192.168.1.2/`, se autenticó con las credenciales de Samba y se accedió al recurso compartido y a la subcarpeta `1` para intercambiar archivos instantáneamente.

## 💻 2. Scripts Desarrollados (`Codigo y Scripts/`)

* [**`01_configurar_red_y_verificar.sh`**](Codigo%20y%20Scripts/01_configurar_red_y_verificar.sh): Inspecciona las interfaces de red IPv4 activas y ejecuta una prueba controlada con `ping -c 4` para validar el enlace físico.
* [**`02_instalar_samba_y_crear_usuario.sh`**](Codigo%20y%20Scripts/02_instalar_samba_y_crear_usuario.sh): Automatiza la instalación de Samba, crea el directorio compartido, aplica permisos `777`, registra el usuario en la base de datos NTLM con `smbpasswd -a` y reinicia el servicio `smbd`.
* [**`03_probar_transferencia.sh`**](Codigo%20y%20Scripts/03_probar_transferencia.sh): Genera un archivo de prueba con metadatos del sistema dentro de la carpeta compartida y calcula su suma de verificación SHA-256 para comprobar la integridad de datos.

## 📋 3. Referencia Técnica de Comandos

| Comando | Sintaxis de Ejemplo | Función a nivel del Sistema Operativo | Justificación Técnica y Flags | 
| ----- | ----- | ----- | ----- | 
| **ping** | `ping -c 4 192.168.1.2` | Envía paquetes ICMP Echo Request a través de la interfaz Ethernet. | La flag **`-c 4`** (*count*) detiene el envío tras 4 paquetes en Linux, evitando ejecución infinita y verificando el estado conectado con 0% de pérdida. | 
| **apt install** | `sudo apt install -y samba` | Gestor de paquetes APT para instalar software en Ubuntu/Debian. | Descarga e instala los demonios del servidor de archivos SMB (`smbd`) y servicio de nombres NetBIOS (`nmbd`). | 
| **mkdir** | `mkdir -p ~/Escritorio/samba_share/1` | Crea jerarquías de directorios en el sistema de archivos `ext4`. | La flag **`-p`** (*parents*) crea la ruta completa sin generar errores si alguno de los directorios ya existe en el VFS. | 
| **chmod** | `chmod -R 777 ~/Escritorio/samba_share` | Modifica los bits de permisos de lectura, escritura y ejecución. | La flag **`-R`** aplica recursivamente la máscara octal `777` para garantizar acceso completo de lectura/escritura entre ambos equipos. | 
| **smbpasswd** | `sudo smbpasswd -a <usuario>` | Administra la base de datos de contraseñas propia de Samba. | La flag **`-a`** registra al usuario en `passdb.tdb` con su hash NTLM, aislando la autenticación de red de la contraseña local en `/etc/shadow`. | 
| **systemctl** | `sudo systemctl restart smbd` | Control del administrador de servicios `systemd` (PID 1). | Recarga en caliente la nueva configuración de recursos compartidos del archivo `/etc/samba/smb.conf`. | 
| **smb://** | `smb://192.168.1.2/` | Esquema URI para protocolos SMB en entornos GNOME. | Invoca al módulo GVfs (`gvfsd-smb`) para montar la carpeta compartida dentro del espacio de usuario de Ubuntu. | 

## 🔬 4. Conclusiones Técnicas

1. **Eficiencia de Samba en Ecosistemas Linux:**
   Se demostró que el protocolo SMB/CIFS es una solución de alto rendimiento y sencilla administración para compartir recursos entre máquinas Linux, facilitando la integración visual nativa en entornos de escritorio como GNOME a través de GVfs.
2. **Diagnóstico Preciso de Red con `-c 4`:**
   El uso de la opción de conteo en el comando `ping` permitió verificar de forma limpia y determinista la disponibilidad del enlace físico y lógico en ambas computadoras antes de inicializar las conexiones de capa de aplicación.
3. **Seguridad y Modularidad de Usuarios:**
   El uso del comando `smbpasswd` evidencia cómo los sistemas operativos desacoplan la seguridad interna (hashes criptográficos de `/etc/shadow`) de los servicios de red expuestos, manteniendo la integridad del sistema anfitrión.