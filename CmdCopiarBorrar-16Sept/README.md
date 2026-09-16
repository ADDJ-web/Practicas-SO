````markdown
# Práctica: Comandos Básicos de Linux

## 📁 Estructura del proyecto

El proyecto está organizado de la siguiente manera:

```text
CmdCopiarBorrar-16Sept/
├── Código/
│   ├── README.txt
│   └── script.sh
│
├── Reporte/
│   ├── README.txt
│   └── Reporte de Práctica - Gestión de Archivos.pdf
│
├── Terminal/
│   ├── README.txt
│   ├── parte1.jpg
│   ├── parte2.jpg
│   └── parte3.jpg
│
├── Video/
│   └── README.txt
│
└── README.md
```

## 🎯 Objetivos

- Practicar el uso de comandos básicos de Linux desde la terminal.
- Aprender a copiar, mover y eliminar archivos y directorios.
- Comprender la navegación y organización del sistema de archivos.
- Utilizar comandos de Linux para realizar operaciones de gestión de archivos.
- Crear y ejecutar un script de Shell para automatizar comandos.

---

# 💻 Comandos utilizados

Durante la práctica se utilizaron diferentes comandos para navegar por el sistema de archivos y realizar operaciones sobre archivos y directorios.

### `pwd`

Muestra la ruta del directorio actual.

```bash
pwd
```

### `ls`

Muestra el contenido del directorio actual.

```bash
ls
```

También se utilizaron diferentes opciones:

```bash
ls -l
ls -la
ls -lh
```

- `-l`: muestra información detallada.
- `-a`: muestra también los archivos ocultos.
- `-h`: muestra los tamaños de forma legible.

### `cd`

Permite cambiar de directorio.

```bash
cd nombre_directorio
```

Para subir un nivel:

```bash
cd ..
```

Para regresar al directorio personal:

```bash
cd ~
```

### `mkdir`

Permite crear directorios.

```bash
mkdir nombre_directorio
```

### `touch`

Permite crear archivos vacíos.

```bash
touch archivo.txt
```

### `cp`

Permite copiar archivos o directorios.

```bash
cp archivo.txt carpeta/
```

Para copiar un directorio completo:

```bash
cp -r carpeta1 carpeta2
```

### `mv`

Permite mover o renombrar archivos y directorios.

Para mover un archivo:

```bash
mv archivo.txt carpeta/
```

Para cambiar el nombre:

```bash
mv archivo.txt nuevo_nombre.txt
```

### `rm`

Permite eliminar archivos.

```bash
rm archivo.txt
```

Para eliminar un directorio y su contenido:

```bash
rm -r carpeta/
```

> **Nota:** `rm` elimina los archivos directamente desde la terminal, por lo que debe utilizarse con precaución.

### `cat`

Permite visualizar el contenido de un archivo de texto.

```bash
cat archivo.txt
```

### `clear`

Limpia la pantalla de la terminal.

```bash
clear
```

---

# 📜 Script de Shell

En la carpeta `Código` se encuentra el archivo `script.sh`, utilizado para automatizar comandos de la práctica.

## Contenido del script

El script puede visualizarse directamente desde GitHub utilizando el siguiente enlace:

[📄 Ver script.sh](./Código/script.sh)

También puede ejecutarse desde la terminal mediante:

```bash
bash Código/script.sh
```

O proporcionando permisos de ejecución:

```bash
chmod +x Código/script.sh
```

Y posteriormente:

```bash
./Código/script.sh
```

---

# 🖥️ Evidencias de la práctica

Las siguientes imágenes muestran las actividades realizadas desde la terminal.

## Parte 1

![Evidencia Parte 1](./Terminal/parte1.jpg)

## Parte 2

![Evidencia Parte 2](./Terminal/parte2.jpg)

## Parte 3

![Evidencia Parte 3](./Terminal/parte3.jpg)

---

# 📄 Reporte

El reporte completo de la práctica se encuentra dentro de la carpeta `Reporte`.

[📄 Ver Reporte de Práctica](./Reporte/Reporte%20de%20Pr%C3%A1ctica%20-%20Gesti%C3%B3n%20de%20Archivos.pdf)

---

# 🎥 Video

La carpeta `Video` contiene la información correspondiente al video de evidencia de la práctica.

---

# 🔬 Conclusiones técnicas

Durante esta práctica se comprendió el funcionamiento básico de la gestión de archivos y directorios en Linux mediante la terminal.

Los comandos `cp`, `mv` y `rm` permiten realizar operaciones fundamentales sobre archivos y carpetas. Por otra parte, comandos como `ls`, `cd` y `pwd` facilitan la navegación y visualización de la estructura del sistema de archivos.

También se comprobó que muchas operaciones que normalmente se realizan mediante una interfaz gráfica pueden llevarse a cabo directamente desde la terminal. Esto permite realizar tareas de manera rápida y facilita la automatización mediante scripts.

El uso de `script.sh` permitió introducir el concepto de automatización mediante Shell, demostrando que una serie de comandos puede ejecutarse de forma organizada mediante un solo archivo.

---

# 👨‍💻 Tecnologías utilizadas

- Linux
- Bash / Shell
- Terminal
- Git
- GitHub
- Markdown

---

# 📌 Organización del proyecto

El proyecto separa sus elementos en diferentes carpetas:

| Carpeta | Contenido |
|---|---|
| `Código` | Script de Shell y documentación del código |
| `Terminal` | Capturas de pantalla de la práctica |
| `Reporte` | Reporte escrito de la práctica |
| `Video` | Material relacionado con el video de evidencia |

Esta organización permite mantener separados el código, las evidencias y la documentación, facilitando la revisión y comprensión del proyecto.
````
