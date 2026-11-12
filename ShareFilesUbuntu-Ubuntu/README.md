# Práctica de Laboratorio: Compartición e Interoperabilidad de Archivos entre Equipos Ubuntu Linux en Red Local mediante Samba (SMB/CIFS)
---

## 🎥 Video Demostrativo en YouTube
[![Ver en YouTube](https://img.shields.io/badge/YouTube-Video%20Demostrativo-red?style=for-the-badge&logo=youtube)](https://youtu.be/211c6FQa2oo)

> 🔗 **Enlace directo al video:** [https://youtu.be/211c6FQa2oo](https://youtu.be/211c6FQa2oo)  
> *(Demostración en vivo en el laboratorio escolar donde se observa la conexión entre las dos laptops con Ubuntu, la verificación de red con el comando `ping -c 4`, el servidor Samba y la navegación en Nautilus hacia el recurso compartido `IsrAMBA`).*

---

## 📁 Índice de Carpetas y Recursos del Proyecto

| Sección | Descripción y Contenido | Enlace Directo |
| :--- | :--- | :--- |
| 💻 **Código** | Scripts en Bash limpios, funcionales y comentados para configurar la red y Samba. | [Ver carpeta `Codigo/`](Codigo/) |
| 📸 **Terminal** | Fotografías reales del laboratorio y transcripción de comandos ejecutados. | [Ver carpeta `Terminal/`](Terminal/) |
| 📑 **Reporte PDF** | Documento formal en PDF con justificación teórica y análisis reflexivo del SO. | [Descargar `Reporte.pdf`](Reporte/Reporte_Transferencia_Ubuntu_Ubuntu_Israel_Carmona.pdf) |
| 📝 **Reporte Word** | Versión editable de Microsoft Word con formato oficial institucional del TecNM. | [Ver `Reporte.docx`](Reporte/Reporte_Transferencia_Ubuntu_Ubuntu_Israel_Carmona.docx) |

---

## 🖼️ Galería de Evidencias (Fotografías Reales del Laboratorio)

| Evidencia | Descripción Técnica | Enlace a la Imagen |
| :--- | :--- | :--- |
| **Evidencia 1: Ping y Comparticiones** | Laptop Huawei (`israel@israel-BOM-WXX9`) con terminal `ping -c 4 192.168.1.2` (0% packet loss) y Nautilus en `Comparticiones Windows en 192.168.1.2` mostrando `IsrAMBA` y `print$`. | [01_ping_y_comparticiones_nautilus.jpg](Terminal/01_ping_y_comparticiones_nautilus.jpg) |
| **Evidencia 2: Carpeta y Ping Cliente** | Laptop cliente (`ubucrys@ubipc`) con la carpeta `IsrAMBA` en el Escritorio conteniendo 5 elementos y terminal con `ping -c 4 192.168.1.7` conectado. | [02_escritorio_isramba_y_ping_ubucrys.jpg](Terminal/02_escritorio_isramba_y_ping_ubucrys.jpg) |
| **Evidencia 3: Conexión Activa Carpeta 1** | Detalle de acceso dentro del recurso `isramba en 192.168.1.2` mostrando la carpeta de destino `1`. | [03_conexion_isramba_carpeta1.jpg](Terminal/03_conexion_isramba_carpeta1.jpg) |
| **Registro de Comandos** | Transcripción íntegra de la sesión de terminal en texto plano. | [Comandos_Terminal_Completos.txt](Terminal/Comandos_Terminal_Completos.txt) |

---

## 🎯 1. Resumen y Propósito de la Práctica

El propósito de esta práctica de laboratorio consistió en interconectar físicamente mediante cable Ethernet y configurar lógicamente dos computadoras portátiles ejecutando el sistema operativo **Ubuntu Linux** (`israel@israel-BOM-WXX9` y `ubucrys@ubipc`) para compartir directorios y archivos en tiempo real mediante el protocolo **SMB/CIFS (Samba)**, sin depender de Internet ni routers comerciales.

### Procedimiento Realizado:
1. **Configuración de Red IPv4 Manual:** En los ajustes de red se configuraron las direcciones IP estáticas en el segmento local (`192.168.1.2` y `192.168.1.7`), asignando la máscara de subred `255.255.255.0` (/24).
2. **Comprobación de Enlace Bidireccional con `-c`:**  
   - En el equipo 1 se ejecutó: `ping -c 4 192.168.1.2` confirmando 4 paquetes recibidos y 0% packet loss.
   - En el equipo 2 se ejecutó: `ping -c 4 192.168.1.7` confirmando 4 paquetes recibidos y 0% packet loss.
3. **Instalación y Despliegue de Samba:** Se instaló el paquete `samba` en Ubuntu, se definió la carpeta compartida `IsrAMBA` con permisos `777` en `/etc/samba/smb.conf` y se creó el usuario de red mediante `sudo smbpasswd -a israel`.
4. **Navegación y Transferencia en Nautilus (GVfs):** En la máquina cliente se abrió el explorador de archivos Nautilus, en *Red* se escribió `smb://192.168.1.2/`, se autenticó con el usuario y contraseña y se accedió al recurso `IsrAMBA` y a la carpeta `1` para intercambiar información instantáneamente.

---

## 💻 2. Scripts Desarrollados (`Codigo/`)

* [**`01_configurar_red_y_verificar.sh`**](Codigo/01_configurar_red_y_verificar.sh): Muestra las interfaces de red IPv4 y ejecuta el test con `ping -c 4` para validar el enlace físico.
* [**`02_instalar_samba_y_crear_usuario.sh`**](Codigo/02_instalar_samba_y_crear_usuario.sh): Instala paquetes Samba, crea el directorio `Escritorio/IsrAMBA/1`, asigna permisos `777`, registra el usuario con `smbpasswd -a` y reinicia el servicio `smbd`.
* [**`03_probar_transferencia.sh`**](Codigo/03_probar_transferencia.sh): Crea un archivo de prueba con metadatos dentro de la carpeta compartida y calcula su firma digital SHA-256 para comprobar su integridad.

---

## 📋 3. Explicación de Comandos Utilizados

| Comando | Sintaxis Ejecutada | Función a nivel del Sistema Operativo | Justificación Técnica y Flags |
| :--- | :--- | :--- | :--- |
| **ping** | `ping -c 4 192.168.1.2` | Envía paquetes ICMP Echo Request a través de la interfaz de red Ethernet. | La opción **`-c 4`** (*count*) es fundamental en Linux: detiene el comando al enviar 4 paquetes (evitando que se ejecute indefinidamente) y confirma el estado "conectado" con 0% de pérdida. |
| **apt install** | `sudo apt install -y samba` | Gestor de paquetes APT para instalar software en Ubuntu/Debian. | Descarga e instala los demonios del servidor de archivos SMB (`smbd`) y servicio de nombres NetBIOS (`nmbd`). |
| **mkdir** | `mkdir -p ~/Escritorio/IsrAMBA/1` | Crea directorios en el sistema de archivos ext4. | La flag **`-p`** asegura la creación de la ruta jerárquica completa sin errores si el inodo ya existía en el VFS. |
| **chmod** | `chmod -R 777 ~/Escritorio/IsrAMBA` | Modifica los permisos de lectura, escritura y ejecución. | La flag **`-R`** aplica recursivamente la máscara octal `777` para garantizar acceso irrestricto de lectura y escritura entre ambas máquinas. |
| **smbpasswd** | `sudo smbpasswd -a israel` | Gestor de contraseñas de la base de datos de Samba. | La flag **`-a`** agrega al usuario en `passdb.tdb` con su hash NTLM, aislando la autenticación de red de la contraseña local de `/etc/shadow`. |
| **systemctl** | `sudo systemctl restart smbd` | Control del gestor del sistema `systemd` (PID 1). | Recarga en memoria la nueva configuración de recursos compartidos del archivo `/etc/samba/smb.conf`. |
| **smb://** | `smb://192.168.1.2/` | URI del esquema de red SMB en GNOME. | Invoca el módulo GVfs (`gvfsd-smb`) para montar la carpeta compartida en el espacio de usuario de Ubuntu. |

---

## 🔬 4. Conclusiones Técnicas

1. **Eficiencia de Samba en Ecosistemas Linux:**  
   Se demostró que el protocolo SMB/CIFS es una solución de alto rendimiento y fácil administración para compartir recursos entre máquinas Linux, facilitando la integración visual en entornos de escritorio como GNOME a través de GVfs.
2. **Diagnóstico Preciso de Red con `-c 4`:**  
   El uso de la opción de conteo en el comando `ping` permitió verificar de forma limpia y automatizada la disponibilidad del enlace físico y lógico en ambas computadoras antes de inicializar las conexiones de capa de aplicación.
3. **Seguridad y Modularidad de Usuarios:**  
   El uso del comando `smbpasswd` evidencia cómo los sistemas operativos desacoplan la seguridad interna (hashes de `/etc/shadow`) de los servicios de red expuestos, manteniendo la integridad del sistema anfitrión.

---
* **Institución:** Tecnológico Nacional de México

