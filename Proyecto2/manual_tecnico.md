# Manual de Tecnico
**UNIVERSIDAD DE SAN CARLOS DE GUATEMALA**  
**FACULTAD DE INGENIERÍA**     
**CATEDRÁTICO:** ING. ZULMA AGUIRRE   
**TUTOR  ACADÉMICO:** JONATAN LEONEL GARCIA ARANA  
**Nombre:** Brandon Antonio Marroquín Pérez  
**Carnet:** 202300813  
**Fecha de Entrega:** 19 de septiembre de 2024  
**Curso:** LABORATORIO LENGUAJES FORMALES Y DE PROGRAMACION Sección B-
**Semestre:** Cuarto Semestre  

---

# Introducción

Este Manual Técnico describe el desarrollo de una aplicación para la visualización y analisasi de archivos .LFP Python y Fortran. El objetivo principal es a base del archivo .LFP que contiene información sobre la configuración de un formulario de inicio de sesión mostrarlo en un html el resultado

El sistema permite la carga y procesamiento de archivos con extensión `.LFP`. A través de la manipulación de estructuras de datos y el uso de algoritmos en Fortran, los datos son analizados para ofrecer una representación gráfica clara en una interfaz desarrollada en Python utilizando Tkinter. La combinación de estas tecnologías garantiza un análisis rápido y preciso.

---

# Objetivos

## 1. General

1.1. Desarrollar una aplicación en Python y Fortran que permita la visualización y análisis de un inicio de sesion, utilizando archivos con extensión `.LFP`, para facilitar la toma de decisiones estratégicas en una empresa internacional.


## 2. Específicos

2.1.  Implementar funciones en Fortran que analicen la información de los archivos `.LFP`, extrayendo y procesando datos sobre ubicaciones geográficas y la saturación del mercado de manera eficiente.

2.2.  Desarrollar una interfaz gráfica en Python utilizando Tkinter que permita cargar archivos `.LFP`, editar su contenido y generar representaciones gráficas de los datos procesados, proporcionando una visualización clara y detallada de sus componentes

----

# Alcances del Sistema

La aplicación para la visualización y análisis de los componentes de un inicio de sesion, desarrollada en Python y Fortran, está diseñada en la toma de decisiones estratégicas sobre la apertura de nuevas ideas. El sistema permite la carga, edición y procesamiento de archivos con extensión `.LFP`, los cuales contienen información sobre los datos que compone cada parte del formulario de inicio de sesión.

Este sistema abarca el análisis eficiente de los datos de localización mediante algoritmos implementados en Fortran, proporcionando resultados precisos que son representados gráficamente en una interfaz gráfica desarrollada en Python utilizando Tkinter. La aplicación soporta tanto la carga manual como automática de los archivos, y permite la visualización dinámica de los gráficos generados en función de los datos procesados. 

El manual técnico proporciona instrucciones detalladas para la instalación, configuración y operación del sistema, asegurando su correcta implementación y facilitando su uso por parte de usuarios encargados de la toma de decisiones.

# Especificación Técnica

## Requisitos de Hardware
- **Sistema operativo**:
  - Windows 10 o superior
  - macOS 10.14 o superior
  - Ubuntu 18.04 o superior
- **Procesador**:
  - Intel Core i5 o superior
  - AMD Ryzen 5 o superior
- **Memoria RAM**:
  - 12 GB o superior
- **Almacenamiento**:
  - 5 GB de espacio libre en disco
- **Tarjeta gráfica**:
  - Intel HD Graphics 620 o superior
  - AMD Radeon R5 o superior
- **Pantalla**:
  - Resolución de 1280 x 720 o superior

## Requisitos de Software
- **Software esencial**:
  - Visual Studio Code: Es el entorno de desarrollo integrado (IDE) utilizado para escribir, depurar y ejecutar el código Fortran.
  - Última versión de Fortran: Es el compilador necesario para compilar y ejecutar el código Fortran.
  - Git (opcional para control de versiones): Es un sistema de control de versiones que permite realizar un seguimiento de los cambios en el código fuente y colaborar con otros desarrolladores.

# Descripción de la Solución

El primer paso en el desarrollo del programa fue crear la interfaz gráfica en Python utilizando la biblioteca Tkinter. Esta interfaz permite al usuario cargar archivos con extensión `.LFP`, ademas se agrego un puntero en tiempo real donde se muestra la ubicación del puntero, ademas luego de implemeto una tabla en la parte inferior de la ventana donde se muestran los resultados de la analisis en Fortran si hay errores en caso contrario no se mostrara nada en la tabla, seguidamente se hicieron los pasos para la logica del programa tanto analizador lexico como sintactico, cabe recalcar que en la parte de pestañas puede visualizarse la tabla de tokens, ademas de eso se podra ver el resultado final el cual es un html con la solucion de dicho archivo.

# LÓGICA DEL PROGRAMA
### LFP-2S24Proyectos_202300813

# Análisis del Código: Fortran y Python

# Resumen del Código en Tkinter

## Librerías Importadas
- **tkinter**: Para crear la interfaz gráfica.
- **tkinter.filedialog**: Para abrir diálogos de selección de archivos.
- **tkinter.messagebox**: Para mostrar mensajes emergentes.
- **tkinter.font**: Para personalizar la fuente de los menús.
- **tkinter.ttk**: Para usar widgets mejorados como `Treeview`.
- **os**: Para interactuar con el sistema operativo.
- **subprocess**: Para ejecutar el programa Fortran.
- **webbrowser**: Para abrir archivos HTML en el navegador.

## Variables Globales

- **Abrir**
  - **Tipo:** string
  - **Descripción:** Ruta del archivo abierto.

- **color_boton**
  - **Tipo:** string
  - **Descripción:** Color de los botones.

- **color_label**
  - **Tipo:** string
  - **Descripción:** Color de las etiquetas.

- **color_fondo**
  - **Tipo:** string
  - **Descripción:** Color de fondo de la ventana.

## Funciones Definidas
- **mostrar_posicion(event)**
  - **Descripción:** Muestra la posición actual del puntero del mouse.

- **Abrir()**
  - **Descripción:** Abre un archivo y carga su contenido en el área de texto.

- **enviar_datos()**
  - **Descripción:** Envía datos al programa Fortran y muestra la salida en la tabla.

- **verificar_ruta(ruta_bandera_grafica)**
  - **Descripción:** Verifica si la ruta del archivo es válida.

- **Guardar(file_path=None)**
  - **Descripción:** Guarda el contenido del área de texto en un archivo.

- **GuardarComo()**
  - **Descripción:** Abre un diálogo para guardar el contenido en un nuevo archivo.

- **NUEVO()**
  - **Descripción:** Limpia el área de texto y ofrece la opción de guardar cambios.

- **tokens()**
  - **Descripción:** Abre un archivo HTML en el navegador.

- **agregar_datos_a_tabla(datos)**
  - **Descripción:** Agrega datos a la tabla desde una lista.

- **agregar_datos_desde_archivo()**
  - **Descripción:** Carga datos desde un archivo de errores en la tabla.

## Elementos de la Interfaz
- **Ventana Principal (`ventana`)**: Configuración de la ventana principal.
- **Etiqueta de Posición (`etiqueta_posicion`)**: Muestra las coordenadas del puntero.
- **Área de Texto (`entrada`)**: Donde se carga el contenido de los archivos.
- **Tabla (`tabla`)**: Muestra los errores y otros datos en formato tabular.
- **Menú (`menu1`)**: Contiene las opciones de archivo y análisis.

## Variables Globales

- **len**
    - **Tipo:** integer
    - **Descripción:** Longitud total del contenido leído desde la entrada estándar.

- **fila**
    - **Tipo:** integer
    - **Descripción:** Número de la línea actual en el contenido.

- **columna**
    - **Tipo:** integer
    - **Descripción:** Número de la columna actual en la línea.

- **estado**
    - **Tipo:** integer
    - **Descripción:** Estado actual del analizador léxico, utilizado para determinar el tipo de token a procesar.

- **puntero**
    - **Tipo:** integer
    - **Descripción:** Posición actual del puntero en el contenido.

- **ios**
    - **Tipo:** integer
    - **Descripción:** Código de estado de entrada/salida para manejar errores de lectura.

- **unidad**
    - **Tipo:** integer
    - **Descripción:** Identificador de la unidad de entrada/salida utilizada (no se utiliza en el código).

- **i**
    - **Tipo:** integer
    - **Descripción:** Variable de control para bucles (no se utiliza en el código).

- **contenido**
    - **Tipo:** character(len=100000)
    - **Descripción:** Cadena que contiene todo el contenido leído desde la entrada estándar.

- **buffer**
    - **Tipo:** character(len=1000)
    - **Descripción:** Buffer temporal para almacenar líneas leídas desde la entrada estándar.

- **char**
    - **Tipo:** character(len=1)
    - **Descripción:** Carácter actual que se está analizando en el contenido.

- **aux_tkn**
    - **Tipo:** character(len=1000)
    - **Descripción:** Cadena temporal utilizada para acumular caracteres de un token antes de agregarlo a la lista de tokens.

## Variables Globales del Módulo `etiqueta`

- **tipo**: 
  - **Tipo**: `Tag`
  - **Descripción**: Estructura que define los atributos de una etiqueta, incluyendo `id`, `tipo`, `alto`, `ancho`, `texto`, `color_texto_r`, `color_texto_g`, `color_texto_b`, `posicion_x`, `posicion_y`.

- **etiqueta_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE`
  - **Descripción**: Arreglo dinámico que almacena instancias de etiquetas.

- **nuevo_etiqueta**:
  - **Tipo**: `Tag`
  - **Descripción**: Instancia temporal para almacenar una nueva etiqueta antes de agregarla al arreglo.

- **temp_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE`
  - **Descripción**: Arreglo temporal utilizado para expandir el `etiqueta_array`.

- **n**:
  - **Tipo**: `integer`
  - **Descripción**: Contador que almacena el tamaño actual del `etiqueta_array`.

- **i**:
  - **Tipo**: `integer`
  - **Descripción**: Variable de control para bucles, utilizada en las subrutinas para iterar sobre las etiquetas.

## Variables Globales del Módulo `error`

- **tipo Err**:
  - **Descripción**: Estructura que define los atributos de un error.
  - **Atributos**:
    - **ultimo_token**: `CHARACTER(LEN = 10000)` - Almacena el último token encontrado.
    - **token_esperado**: `CHARACTER(LEN = 10000)` - Almacena el token que se esperaba encontrar.
    - **fila**: `INTEGER` - Almacena el número de fila donde ocurrió el error.
    - **columna**: `INTEGER` - Almacena el número de columna donde ocurrió el error.

- **error_array**:
  - **Tipo**: `type(Err), ALLOCATABLE` - Arreglo que almacena todos los errores registrados.

- **nuevo_error**:
  - **Tipo**: `type(Err)` - Instancia temporal que se utiliza para almacenar un nuevo error antes de agregarlo a `error_array`.

- **n**:
  - **Tipo**: `INTEGER` - Contador que almacena el tamaño actual del `error_array`.

- **temp_array**:
  - **Tipo**: `type(Err), ALLOCATABLE` - Arreglo temporal utilizado para expandir el `error_array` cuando se agregan nuevos errores.

- **unidad**:
  - **Tipo**: `INTEGER` - Representa la unidad de archivo para las operaciones de escritura.

- **iostat**:
  - **Tipo**: `INTEGER` - Variable que captura el estado de la operación de apertura de archivos.

- **nombre_archivo**:
  - **Tipo**: `CHARACTER(LEN=100)` - Almacena el nombre del archivo donde se escribirán los errores.

- **line_error**:
  - **Tipo**: `CHARACTER(LEN=200)` - Almacena la línea completa que representa un error para escribir en el archivo.

## Variables Globales del Módulo `add_todo`

- **tipo contenido_add**:
  - **Descripción**: Estructura que define los atributos de un contenido que se desea agregar.
  - **Atributos**:
    - **id**: `CHARACTER(LEN = 50)` - Almacena el identificador del contenido.
    - **add**: `CHARACTER(LEN = 100)` - Almacena el contenido que se desea agregar.

- **contenido_add_array**:
  - **Tipo**: `type(contenido_add), ALLOCATABLE` - Arreglo que almacena todos los contenidos que se han agregado.

- **n**:
  - **Tipo**: `INTEGER` - Variable que almacena el tamaño actual de `contenido_add_array`.

- **temp_array**:
  - **Tipo**: `type(contenido_add), ALLOCATABLE` - Arreglo temporal utilizado para copiar el contenido existente antes de agregar un nuevo elemento.

## Variables Globales del Módulo `Boton`

- **tipo Tag**:
  - **Descripción**: Estructura que define los atributos de un botón.
  - **Atributos**:
    - **id**: `CHARACTER(LEN = 5000)` - Almacena el identificador del botón.
    - **tipo**: `CHARACTER(LEN = 2000)` - Almacena el tipo del botón (siempre será "Boton").
    - **texto**: `CHARACTER(LEN = 20000)` - Almacena el texto que se muestra en el botón.
    - **posicion_x**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje X del botón.
    - **posicion_y**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje Y del botón.

- **Boton_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE` - Arreglo que almacena todos los botones que se han creado.

- **nuevo_Boton**:
  - **Tipo**: `type(Tag)` - Instancia de un botón que se va a agregar a la lista.

- **n**:
  - **Tipo**: `INTEGER` - Variable que almacena el tamaño actual de `Boton_array`.

- **temp_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE` - Arreglo temporal utilizado para copiar los botones existentes antes de agregar un nuevo botón.


## Funciones y Subrutinas

1. **agregar_Boton(id)**:
   - **Descripción**: Agrega un nuevo botón a `Boton_array`.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del botón.
   - **Proceso**: Inicializa los atributos del botón y lo agrega al arreglo de botones, redimensionando si es necesario.

2. **imprimir_Botons()**:
   - **Descripción**: Imprime todos los botones en `Boton_array`.
   - **Proceso**: Revisa si hay botones en el arreglo y, si los hay, imprime sus atributos.

3. **Boton_set_texto(id, texto)**:
   - **Descripción**: Modifica el texto de un botón existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del botón.
     - `texto`: `CHARACTER(LEN=*)` - Nuevo texto para el botón.

4. **Boton_set_posicion(id, posicion_x, posicion_y)**:
   - **Descripción**: Modifica la posición de un botón existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del botón.
     - `posicion_x`: `CHARACTER(LEN=*)` - Nueva posición en el eje X.
     - `posicion_y`: `CHARACTER(LEN=*)` - Nueva posición en el eje Y.

5. **buscar_Boton_por_id(id)**:
   - **Descripción**: Busca un botón por su ID y devuelve un valor lógico que indica si fue encontrado.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del botón.
   - **Resultado**: `encontrado`: `LOGICAL` - Indica si el botón fue encontrado.

## Variables Globales del Módulo `clave`

- **tipo Tag**:
  - **Descripción**: Estructura que define los atributos de una clave.
  - **Atributos**:
    - **id**: `CHARACTER(LEN = 5000)` - Almacena el identificador de la clave.
    - **tipo**: `CHARACTER(LEN = 2000)` - Almacena el tipo de clave (siempre será "clave").
    - **texto**: `CHARACTER(LEN = 2000)` - Almacena el texto asociado a la clave.
    - **posicion_x**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje X de la clave.
    - **posicion_y**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje Y de la clave.

- **clave_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE` - Arreglo que almacena todas las claves que se han creado.

- **nuevo_clave**:
  - **Tipo**: `type(Tag)` - Instancia de una clave que se va a agregar a la lista.

- **n**:
  - **Tipo**: `INTEGER` - Variable que almacena el tamaño actual de `clave_array`.

- **temp_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE` - Arreglo temporal utilizado para copiar las claves existentes antes de agregar una nueva clave.

## Funciones y Subrutinas

1. **agregar_clave(id)**:
   - **Descripción**: Agrega un nuevo clave a `clave_array`.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador de la clave.

2. **imprimir_claves()**:
   - **Descripción**: Imprime todos los claves en `clave_array`.

3. **clave_set_texto(id, texto)**:
   - **Descripción**: Modifica el texto de una clave existente, identificada por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador de la clave.
     - `texto`: `CHARACTER(LEN=*)` - Nuevo texto para la clave.

4. **clave_set_posicion(id, posicion_x, posicion_y)**:
   - **Descripción**: Modifica la posición de una clave existente, identificada por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador de la clave.
     - `posicion_x`: `CHARACTER(LEN=*)` - Nueva posición en el eje X.
     - `posicion_y`: `CHARACTER(LEN=*)` - Nueva posición en el eje Y.

5. **buscar_clave_por_id(id)**:
   - **Descripción**: Busca una clave por su ID y devuelve un valor lógico que indica si fue encontrada.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador de la clave.
   - **Resultado**: `encontrado`: `LOGICAL` - Indica si la clave fue encontrada.

## Variables Globales del Módulo `contenedor`

- **tipo Tag**:
  - **Descripción**: Estructura que define los atributos de un contenedor.
  - **Atributos**:
    - **id**: `CHARACTER(LEN = 5000)` - Almacena el identificador del contenedor.
    - **tipo**: `CHARACTER(LEN = 2000)` - Almacena el tipo de contenedor (siempre será "contenedor").
    - **alto**: `CHARACTER(LEN = 2000)` - Almacena la altura del contenedor.
    - **ancho**: `CHARACTER(LEN = 2000)` - Almacena el ancho del contenedor.
    - **fondo**: `CHARACTER(LEN = 2000)` - Almacena la profundidad del contenedor.
    - **color_fondo_r**: `CHARACTER(LEN = 5000)` - Almacena el valor rojo del color de fondo.
    - **color_fondo_g**: `CHARACTER(LEN = 5000)` - Almacena el valor verde del color de fondo.
    - **color_fondo_b**: `CHARACTER(LEN = 5000)` - Almacena el valor azul del color de fondo.
    - **posicion_x**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje X del contenedor.
    - **posicion_y**: `CHARACTER(LEN = 5000)` - Almacena la posición en el eje Y del contenedor.

- **contenedor_array**:
  - **Tipo**: `type(Tag), ALLOCATABLE` - Arreglo que almacena todos los contenedores que se han creado.

## Funciones y Subrutinas

1. **agregar_contenedor(id)**:
   - **Descripción**: Agrega un nuevo contenedor a `contenedor_array`.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.

2. **imprimir_contenedores()**:
   - **Descripción**: Imprime todos los contenedores en `contenedor_array`.

3. **contenedor_set_alto(id, alto)**:
   - **Descripción**: Modifica la altura de un contenedor existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.
     - `alto`: `CHARACTER(LEN=*)` - Nueva altura para el contenedor.

4. **contenedor_set_ancho(id, ancho)**:
   - **Descripción**: Modifica el ancho de un contenedor existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.
     - `ancho`: `CHARACTER(LEN=*)` - Nuevo ancho para el contenedor.

5. **contenedor_set_color_fondo(id, color_fondo_r, color_fondo_g, color_fondo_b)**:
   - **Descripción**: Modifica el color de fondo de un contenedor existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.
     - `color_fondo_r`: `CHARACTER(LEN=*)` - Nuevo valor rojo del color de fondo.
     - `color_fondo_g`: `CHARACTER(LEN=*)` - Nuevo valor verde del color de fondo.
     - `color_fondo_b`: `CHARACTER(LEN=*)` - Nuevo valor azul del color de fondo.

6. **contenedor_set_posicion(id, posicion_x, posicion_y)**:
   - **Descripción**: Modifica la posición de un contenedor existente, identificado por su ID.
   - **Parámetros**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.
     - `posicion_x`: `CHARACTER(LEN=*)` - Nueva posición en el eje X.
     - `posicion_y`: `CHARACTER(LEN=*)` - Nueva posición en el eje Y.

7. **buscar_contenedor_por_id(id)**:
   - **Descripción**: Busca un contenedor por su ID y devuelve un valor lógico que indica si fue encontrado.
   - **Parámetro**: 
     - `id`: `CHARACTER(LEN=*)` - Identificador del contenedor.
   - **Resultado**: `encontrado`: `LOGICAL` - Indica si el contenedor fue encontrado.

## Variables Globales del Módulo `error_lexico`

- **tipo Err**:
  - **Descripción**: Estructura que define los atributos de un error léxico.
  - **Atributos**:
    - **ultimo_token**: `CHARACTER(LEN = 10000)` - Almacena el último token encontrado.
    - **token_esperado**: `CHARACTER(LEN = 10000)` - Almacena el token que se esperaba encontrar.
    - **fila**: `INTEGER` - Almacena la fila donde se encontró el error.
    - **columna**: `INTEGER` - Almacena la columna donde se encontró el error.

- **error_array**:
  - **Tipo**: `type(Err), ALLOCATABLE` - Arreglo que almacena todos los errores léxicos detectados.

## Funciones y Subrutinas

1. **agregar_error_lexico(ultimo_token, token_esperado, fila, columna)**:
   - **Descripción**: Agrega un nuevo error léxico a `error_array`.
   - **Parámetros**: 
     - `ultimo_token`: `CHARACTER(LEN=*)` - Último token encontrado.
     - `token_esperado`: `CHARACTER(LEN=*)` - Token esperado.
     - `fila`: `INTEGER` - Fila donde se encontró el error.
     - `columna`: `INTEGER` - Columna donde se encontró el error.

2. **imprimir_errores_lexico()**:
   - **Descripción**: Imprime todos los errores léxicos almacenados en `error_array` en la consola.

3. **escribir_errores_lexico_txt()**:
   - **Descripción**: Escribe todos los errores léxicos en un archivo de texto.
   - **Parámetros**: Ninguno.
   - **Descripción del archivo**: Los errores se guardan en la ruta especificada, incluyendo información sobre la fila, columna, último token y mensaje de error.

# Módulo generador_mod

Este módulo se encarga de generar archivos HTML y CSS utilizando datos almacenados en arreglos. Contiene dos subrutinas principales.

## 1. Subrutina generador_html_css

- **Propósito:** Inicializa rutas de archivos y llama a subrutinas para escribir contenido en archivos HTML y CSS. También verifica la asignación de memoria para un arreglo de datos adicionales.
- **Variables:**
    - `ruta_html`: Ruta para el archivo HTML.
    - `ruta_css`: Ruta para el archivo CSS.
    - `i`: Contador para bucles.
- **Flujo:**
    - Asigna rutas a los archivos.
    - Llama a `escribir_html` y `escribir_css`.
    - Imprime un mensaje de confirmación.
    - Verifica si `contenido_add_array` está asignado y, si es así, imprime los datos de cada entrada.

## 2. Subrutina escribir_html

- **Propósito:** Crea el archivo HTML, estructurando el contenido según los datos de `contenido_add_array` y `contenedor_array`.
- **Variables:**
    - `i, j, k, l, m, n, o, p, a, b, c, d, e, f`: Contadores para bucles.
    - `largo`: Se declara pero no se usa.
- **Flujo:**
    - Abre el archivo HTML para escribir.
    - Escribe las etiquetas HTML básicas: `<html>`, `<head>`, `<body>`.
    - Utiliza bucles para iterar sobre `contenido_add_array` y `contenedor_array` para crear `div` con estilos CSS dinámicos basados en propiedades como `ancho`, `alto`, y `color_fondo`.
    - Se generan etiquetas adicionales (`label`, `input`, `button`) para formularios basándose en `etiqueta_array`, `texto_array` y `clave_array`.
    - Cierra las etiquetas HTML adecuadamente.

## Variables del Módulo texto

### Tipo Tag
- `id`: `CHARACTER(LEN = 5000)`
  - **Descripción**: Identificador único del texto.

- `tipo`: `CHARACTER(LEN = 2000)`
  - **Descripción**: Tipo de contenido que representa el texto (en este caso, siempre es 'texto').

- `texto`: `CHARACTER(LEN = 2000)`
  - **Descripción**: Contenido textual que se almacenará.

- `posicion_x`: `CHARACTER(LEN = 5000)`
  - **Descripción**: Posición en el eje X donde se mostrará el texto.

- `posicion_y`: `CHARACTER(LEN = 5000)`
  - **Descripción**: Posición en el eje Y donde se mostrará el texto.

### Arreglos
- `texto_array`: `TYPE(Tag), ALLOCATABLE :: texto_array(:)`
  - **Descripción**: Arreglo dinámico que almacena múltiples objetos de tipo `Tag`, permitiendo gestionar una lista de textos.

### Subrutina agregar_texto
- `nuevo_texto`: `TYPE(Tag)`
  - **Descripción**: Variable temporal para almacenar un nuevo texto que se añadirá al arreglo.

- `n`: `INTEGER`
  - **Descripción**: Contador que almacena el número actual de elementos en el arreglo `texto_array`.

- `temp_array`: `TYPE(Tag), ALLOCATABLE :: temp_array(:)`
  - **Descripción**: Arreglo temporal utilizado para realizar la copia y expansión de `texto_array` al agregar un nuevo texto.

### Subrutina imprimir_textos
- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para iterar a través de los elementos del arreglo `texto_array` al imprimir su contenido.

### Subrutina texto_set_texto
- `id`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Identificador del texto cuyo contenido se desea actualizar.

- `texto`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Nuevo contenido que se asignará al texto identificado.

- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para buscar el texto correspondiente en el arreglo.

### Subrutina texto_set_posicion
- `id`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Identificador del texto cuya posición se desea actualizar.

- `posicion_x`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Nueva posición en el eje X para el texto.

- `posicion_y`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Nueva posición en el eje Y para el texto.

- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para buscar el texto correspondiente en el arreglo.

### Función buscar_texto_por_id
- `id`: `CHARACTER(LEN=*), INTENT(IN)`
  - **Descripción**: Identificador del texto que se desea buscar.

- `encontrado`: `LOGICAL`
  - **Descripción**: Variable que indica si el texto con el identificador dado fue encontrado en el arreglo.

- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para iterar a través de los elementos del arreglo `texto_array` durante la búsqueda.

## Variables del Módulo token

### Tipo Tkn
- `lexema`: `CHARACTER(LEN = 10000)`
  - **Descripción**: Cadena que representa el lexema (la secuencia de caracteres) del token.

- `tipo`: `CHARACTER(LEN = 20000)`
  - **Descripción**: Cadena que indica el tipo del token, que puede ser un identificador, operador, etc.

- `fila`: `INTEGER`
  - **Descripción**: Número de la fila en el código fuente donde se encontró el token.

- `columna`: `INTEGER`
  - **Descripción**: Número de la columna en la fila donde se encontró el token.

### Arreglos
- `token_array`: `TYPE(Tkn), ALLOCATABLE :: token_array(:)`
  - **Descripción**: Arreglo dinámico que almacena múltiples objetos de tipo `Tkn`, permitiendo gestionar una lista de tokens.

### Subrutina agregar_token
- `nuevo_token`: `TYPE(Tkn)`
  - **Descripción**: Variable temporal que representa un nuevo token a agregar a la lista de tokens.

- `n`: `INTEGER`
  - **Descripción**: Contador que almacena el número actual de elementos en el arreglo `token_array`.

- `temp_array`: `TYPE(Tkn), ALLOCATABLE :: temp_array(:)`
  - **Descripción**: Arreglo temporal utilizado para copiar y expandir `token_array` al agregar un nuevo token.

### Subrutina imprimir_tokens
- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para iterar a través de los elementos del arreglo `token_array`.

- `str_fila`: `CHARACTER(LEN=20)`
  - **Descripción**: Cadena que almacena la representación en texto de la fila del token.

- `str_columna`: `CHARACTER(LEN=20)`
  - **Descripción**: Cadena que almacena la representación en texto de la columna del token.

### Subrutina generar_html_tokens
- `html_content`: `CHARACTER(LEN=100000)`
  - **Descripción**: Variable que almacena el contenido HTML que se generará (aunque no se utiliza en el código proporcionado).

- `str_tipo`: `CHARACTER(LEN=100)`
  - **Descripción**: Cadena que representa el tipo del token en formato de texto.

- `str_columna`: `CHARACTER(LEN=20)`
  - **Descripción**: Cadena que almacena la representación en texto de la columna del token (similar a `str_columna` de `imprimir_tokens`).

- `str_fila`: `CHARACTER(LEN=20)`
  - **Descripción**: Cadena que almacena la representación en texto de la fila del token (similar a `str_fila` de `imprimir_tokens`).

- `char_token`: `CHARACTER(LEN=100)`
  - **Descripción**: Cadena que almacena el lexema del token en formato de texto.

- `file_unit`: `INTEGER`
  - **Descripción**: Unidad de archivo utilizada para abrir y escribir el archivo HTML.

- `ios`: `INTEGER`
  - **Descripción**: Variable de estado de entrada/salida que indica si hubo errores al abrir el archivo.

- `i`: `INTEGER`
  - **Descripción**: Contador utilizado para iterar a través de los elementos del arreglo `token_array` al generar el HTML.


# Acontinuación la logica del analizador de una manera más clara
 El arbol del codigo es el siguiente:

![imagen](./img/arbol.png)

las tablas del arbol tanto de follow como de estado de lo anterior son las siguientes:

![imagen](./img/tablas.png)

y por ultimo tenemos el automata: 

![imagen](./img/automata.png)