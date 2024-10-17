MODULE generador_html_css
    USE etiqueta   ! Asegúrate de que este módulo define correctamente el tipo Tag
    USE contenedor  ! Asegúrate de que este módulo define correctamente el tipo contenedor
    IMPLICIT NONE

CONTAINS
    SUBROUTINE generar_html_css()
        IMPLICIT NONE

        ! Declaración de los arrays internos
        TYPE(Tag), ALLOCATABLE :: etiqueta_array(:)
        TYPE(contenedor), ALLOCATABLE :: contenedor_array(:)
        INTEGER :: i, unidad_html, unidad_css
        CHARACTER(len=256) :: filename_html, filename_css

        ! Inicialización de las etiquetas y contenedores
        ALLOCATE(etiqueta_array(10))  ! Ajusta el tamaño según tus necesidades
        ALLOCATE(contenedor_array(5))  ! Ajusta el tamaño según tus necesidades

        ! Configura las etiquetas
        DO i = 1, SIZE(etiqueta_array)
            etiqueta_array(i)%id = TRIM(ADJUSTL(itoa(i)))  ! Convierte el entero a cadena
            etiqueta_array(i)%contenido = 'Texto de ejemplo ' // TRIM(ADJUSTL(itoa(i)))
            etiqueta_array(i)%color_fondo_r = 100
            etiqueta_array(i)%color_fondo_g = 150
            etiqueta_array(i)%color_fondo_b = 200
            etiqueta_array(i)%tamano_fuente = 14 + i  ! Tamaño de fuente variable
        END DO

        ! Configura los contenedores
        DO i = 1, SIZE(contenedor_array)
            contenedor_array(i)%id = TRIM(ADJUSTL(itoa(i)))  ! Convierte el entero a cadena
            contenedor_array(i)%color_fondo_r = 220
            contenedor_array(i)%color_fondo_g = 230
            contenedor_array(i)%color_fondo_b = 240
            contenedor_array(i)%ancho = 300 + i * 20
            contenedor_array(i)%alto = 200 + i * 10
            contenedor_array(i)%posicion_x = 50 + i * 30
            contenedor_array(i)%posicion_y = 100 + i * 40
        END DO

        ! Nombres de los archivos de salida
        filename_html = "pagina.html"
        filename_css = "styles.css"

        ! Abre el archivo HTML en modo de escritura
        OPEN(unit=unidad_html, file=filename_html, status="replace", action="write")

        ! Escribe el contenido inicial del HTML
        WRITE(unidad_html, '(A)') "<!DOCTYPE html>"
        WRITE(unidad_html, '(A)') "<html lang=""es"">"
        WRITE(unidad_html, '(A)') "    <head>"
        WRITE(unidad_html, '(A)') "        <meta charset=""UTF-8"">"
        WRITE(unidad_html, '(A)') "        <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">"
        WRITE(unidad_html, '(A)') "        <title>Página Generada</title>"
        WRITE(unidad_html, '(A)') "        <link rel=""stylesheet"" href=""styles.css"">"
        WRITE(unidad_html, '(A)') "    </head>"
        WRITE(unidad_html, '(A)') "    <body>"

        ! Genera las etiquetas en el HTML
        DO i = 1, SIZE(etiqueta_array)
            WRITE(unidad_html, '(A)') "        <div class=""etiqueta"" id=""etiqueta" // TRIM(ADJUSTL(etiqueta_array(i)%id)) // "" >"
            WRITE(unidad_html, '(A)') "            <p>" // TRIM(ADJUSTL(etiqueta_array(i)%contenido)) // "</p>"
            WRITE(unidad_html, '(A)') "        </div>"
        END DO

        ! Genera los contenedores en el HTML
        DO i = 1, SIZE(contenedor_array)
            WRITE(unidad_html, '(A)') "        <div class=""contenedor"" id=""contenedor" // TRIM(ADJUSTL(contenedor_array(i)%id)) // "" >"
            WRITE(unidad_html, '(A)') "        </div>"
        END DO

        ! Cierra el HTML
        WRITE(unidad_html, '(A)') "    </body>"
        WRITE(unidad_html, '(A)') "</html>"

        ! Cierra el archivo HTML
        CLOSE(unidad_html)

        ! Abre el archivo CSS en modo de escritura
        OPEN(unit=unidad_css, file=filename_css, status="replace", action="write")

        ! Genera los estilos CSS para las etiquetas
        DO i = 1, SIZE(etiqueta_array)
            WRITE(unidad_css, '(A)') "        #etiqueta" // TRIM(ADJUSTL(etiqueta_array(i)%id)) // " {"
            WRITE(unidad_css, '(A)') "            color: rgb("// & 
                TRIM(ADJUSTL(etiqueta_array(i)%color_fondo_r)) // "," // & 
                TRIM(ADJUSTL(etiqueta_array(i)%color_fondo_g)) // "," // & 
                TRIM(ADJUSTL(etiqueta_array(i)%color_fondo_b)) // ");"
            WRITE(unidad_css, '(A)') "            font-size: " // TRIM(ADJUSTL(etiqueta_array(i)%tamano_fuente)) // "px;"
            WRITE(unidad_css, '(A)') "        }"
        END DO

        ! Genera los estilos CSS para los contenedores
        DO i = 1, SIZE(contenedor_array)
            WRITE(unidad_css, '(A)') "        #contenedor" // TRIM(ADJUSTL(contenedor_array(i)%id)) // " {"
            WRITE(unidad_css, '(A)') "            background-color: rgb("// & 
                TRIM(ADJUSTL(contenedor_array(i)%color_fondo_r)) // "," // & 
                TRIM(ADJUSTL(contenedor_array(i)%color_fondo_g)) // "," // & 
                TRIM(ADJUSTL(contenedor_array(i)%color_fondo_b)) // ");"
            WRITE(unidad_css, '(A)') "            width: " // TRIM(ADJUSTL(contenedor_array(i)%ancho)) // "px;"
            WRITE(unidad_css, '(A)') "            height: " // TRIM(ADJUSTL(contenedor_array(i)%alto)) // "px;"
            WRITE(unidad_css, '(A)') "            position: absolute;"
            WRITE(unidad_css, '(A)') "            left: " // TRIM(ADJUSTL(contenedor_array(i)%posicion_x)) // "px;"
            WRITE(unidad_css, '(A)') "            top: " // TRIM(ADJUSTL(contenedor_array(i)%posicion_y)) // "px;"
            WRITE(unidad_css, '(A)') "        }"
        END DO

        ! Cierra el archivo CSS
        CLOSE(unidad_css)

        ! Libera la memoria
        DEALLOCATE(etiqueta_array)
        DEALLOCATE(contenedor_array)

    END SUBROUTINE generar_html_css
END MODULE generador_html_css