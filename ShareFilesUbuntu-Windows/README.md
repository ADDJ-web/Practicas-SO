# 🐧🪟 ShareFilesUbuntu-Windows
### Compartición de Archivos en Red Local Heterogénea (Ubuntu - Ubuntu y Ubuntu - Windows con Samba)

Implementación, automatización y documentación técnica para la interconexión física y lógica mediante protocolo **SMB/CIFS (Samba)** entre sistemas operativos Linux (Ubuntu) y Microsoft Windows en una red local aislada.

---

## 🎥 Video Demostrativo
[![Ver en YouTube](https://img.shields.io/badge/YouTube-Video%20Demostrativo-red?style=for-the-badge&logo=youtube)](https://youtu.be/0L9AYAHT8nM)

> 🔗 **Enlace directo al video:** [https://youtu.be/0L9AYAHT8nM](https://youtu.be/0L9AYAHT8nM)  
> *(Demostración práctica donde se observa la configuración de red IPv4 manual, la verificación de enlace con `ping -c`, la configuración del servidor Samba y la transferencia bidireccional de archivos entre Ubuntu y Windows).*

---

## 📁 Estructura del Repositorio

El proyecto está organizado siguiendo exactamente la jerarquía de directorios de **`ShareFilesUbuntu-Windows`**:

| Carpeta | Descripción y Contenido | Enlace Directo |
| :--- | :--- | :--- |
| 💻 **Código y Scripts** | Scripts en Bash limpios, funcionales y comentados para automatizar la red y el servidor Samba. | [Ver carpeta `Codigo y Scripts/`](Codigo%20y%20Scripts/) |
| 📑 **Reporte** | Documentación técnica en formato PDF y editable con el análisis teórico y arquitectura del sistema. | [Ver carpeta `Reporte/`](Reporte/) |
| 📸 **Terminal** | Capturas nítidas, evidencias gráficas y registro íntegro de los comandos ejecutados en consola. | [Ver carpeta `Terminal/`](Terminal/) |
| 🎬 **Video** | Recursos multimedia, guión técnico y material de apoyo de la demostración en vivo. | [Ver carpeta `Video/`](Video/) |

---

## 🖼️ Galería de Evidencias (Entorno de Pruebas)

| Evidencia | Descripción Técnica | Enlace en `Terminal/` |
| :--- | :--- | :--- |
| **Evidencia 1: Nautilus en Ubuntu** | Explorador de archivos de Ubuntu conectado al recurso compartido mediante protocolo SMB (`192.168.1.2`). | [01_conexion_nautilus.jpg](Terminal/01_conexion_nautilus.jpg) |
| **Evidencia 2: Red IPv4 en Windows** | Ajustes de Ethernet con IP estática `192.168.1.7`, máscara `255.255.255.0` y ventana Ejecutar (`Win + R`). | [02_configuracion_red_windows.jpg](Terminal/02_configuracion_red_windows.jpg) |
| **Evidencia 3: Carpeta Origen en Ubuntu** | Directorio compartido en Ubuntu junto con terminal ejecutando `ping -c 4` en estado conectado. | [03_carpeta_origen_ubuntu.jpg](Terminal/03_carpeta_origen_ubuntu.jpg) |
| **Evidencia 4: Acceso en Windows** | Explorador de Archivos de Windows en `Red > 192.168.1.2` mostrando los directorios compartidos en tiempo real. | [04_acceso_red_windows.jpg](Terminal/04_acceso_red_windows.jpg) |
| **Registro de Comandos** | Transcripción completa de la sesión de terminal en texto plano. | [Comandos_Terminal_Completos.txt](Terminal/Comandos_Terminal_Completos.txt) |

---

## 🎯 1. Resumen y Propósito del Proyecto

El objetivo de esta implementación es interconectar físicamente mediante cable Ethernet (par trenzado directo o cruzado) y configurar lógicamente dos equipos con sistemas operativos heterogéneos (**Ubuntu Linux** y **Microsoft Windows**) para compartir y transferir archivos de forma bidireccional, rápida y transparente, sin depender de conexión a Internet ni servicios en la nube.

### Flujo de Configuración Realizado:
1. **Configuración de Red IPv4 Manual:** Se asignaron direcciones IP estáticas dentro del mismo segmento de red local (`192.168.1.2` para el servidor Ubuntu y `192.168.1.7` para el cliente Windows), utilizando la máscara de subred `255.255.255.0`.
2. **Comprobación de Enlace con `-c`:** Se ejecutó `ping -c 4 192.168.1.2`, enviando exactamente 4 paquetes ICMP y confirmando el estado **CONECTADO** (0% de pérdida de paquetes).
3. **Instalación de Samba y Gestión de Usuarios:** Se instaló el demonio Samba en Ubuntu, se declaró el recurso compartido con permisos `777` en `/etc/samba/smb.conf` y se dio de alta el usuario de red mediante `sudo smbpasswd -a <usuario>`.
4. **Conexión Ubuntu a Ubuntu:** Desde el gestor de archivos Nautilus se accedió a `smb://192.168.1.2/<recurso_compartido>`, autenticando con las credenciales de Samba.
5. **Conexión Ubuntu a Windows:** Tras conectar el cable Ethernet, se ejecutó `Win + R` ingresando la ruta UNC `\\192.168.1.2\`, autenticando el acceso para visualizar, crear y modificar directorios en tiempo real desde el Explorador de Windows.

---

## 💻 2. Scripts Desarrollados (`Codigo y Scripts/`)

* [**`01_configurar_red_y_verificar.sh`**](Codigo%20y%20Scripts/01_configurar_red_y_verificar.sh): Inspecciona la interfaz de red IPv4 activa y ejecuta una prueba controlada con `ping -c 4` para validar la conectividad punto a punto.
* [**`02_instalar_samba_y_crear_usuario.sh`**](Codigo%20y%20Scripts/02_instalar_samba_y_crear_usuario.sh): Automatiza la instalación de Samba, crea el directorio compartido, aplica permisos `777`, registra el usuario en la base de datos NTLM con `smbpasswd -a` y reinicia el servicio `smbd`.
* [**`03_probar_transferencia.sh`**](Codigo%20y%20Scripts/03_probar_transferencia.sh): Genera un archivo de prueba con metadatos del sistema dentro del recurso compartido y calcula su suma de verificación SHA-256 para validar la integridad de datos.

---

## 📋 3. Referencia Técnica de Comandos

| Comando | Sintaxis de Ejemplo | Función a nivel del Sistema Operativo | Justificación Técnica y Flags |
| :--- | :--- | :--- | :--- |
| **ping** | `ping -c 4 192.168.1.2` | Envía paquetes ICMP Echo Request a través de la interfaz física. | La flag **`-c 4`** (*count*) detiene el envío tras 4 paquetes en Linux, evitando ejecución infinita y verificando el estado conectado. |
| **apt install** | `sudo apt install -y samba` | Gestor de paquetes APT en sistemas Debian/Ubuntu. | Instala los demonios del servidor de archivos SMB (`smbd`) y resolución de nombres NetBIOS (`nmbd`). |
| **mkdir** | `mkdir -p ~/samba_share/1` | Crea jerarquías de directorios en el sistema de archivos `ext4`. | La flag **`-p`** (*parents*) crea toda la ruta de directorios sin generar errores si alguno ya existe en el VFS. |
| **chmod** | `chmod -R 777 ~/samba_share` | Modifica los bits de permisos de lectura, escritura y ejecución. | La flag **`-R`** aplica recursivamente la máscara octal `777` para garantizar acceso de lectura/escritura a clientes externos. |
| **smbpasswd** | `sudo smbpasswd -a <usuario>` | Administra la base de datos de contraseñas propia de Samba. | La flag **`-a`** registra al usuario con su hash NTLM en `passdb.tdb`, aislando la red de las credenciales locales en `/etc/shadow`. |
| **systemctl** | `sudo systemctl restart smbd` | Control del administrador de servicios `systemd` (PID 1). | Recarga en caliente la configuración de recursos compartidos definida en `/etc/samba/smb.conf`. |
| **Win + R** | `\\192.168.1.2\` | Cuadro de diálogo Ejecutar en entornos Windows NT. | Emplea la sintaxis UNC (*Universal Naming Convention*) para montar y abrir recursos remotos en el Explorador de Archivos. |
| **smb://** | `smb://192.168.1.2/share` | Esquema URI para protocolos SMB en entornos GNOME. | Invoca al módulo GVfs para integrar el recurso remoto dentro del espacio de usuario de Ubuntu. |

---

## 🔬 4. Conclusiones Técnicas

1. **Aislamiento Seguro de Credenciales:**  
   El uso de `smbpasswd` es indispensable porque los hashes criptográficos de Linux (`/etc/shadow`) son incompatibles con el mecanismo de autenticación SMB de Windows. Samba gestiona su propia base de datos NTLM para autenticar clientes sin exponer las contraseñas del sistema anfitrión.
2. **Control de Diagnóstico con `-c`:**  
   A diferencia de Windows (donde `ping` envía 4 paquetes por defecto), en Linux se ejecuta de forma continua. El parámetro `-c 4` permite integrar comprobaciones de red limpias y deterministas tanto en consola como en scripts de automatización.
3. **Interoperabilidad Multiplataforma:**  
   Mediante direccionamiento estático con máscara `255.255.255.0` y el protocolo estándar SMB/CIFS, dos equipos con arquitecturas de sistema operativo distintas pueden intercambiar información a máxima velocidad de interfaz física sin requerir routers ni acceso a Internet.