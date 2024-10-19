MODULE generador_mod
    use etiqueta
    use contenedor
    use clave
    use texto
    use add_todo

    IMPLICIT NONE
    CONTAINS

    SUBROUTINE generador_html_css
        integer :: i

        CHARACTER(LEN=100) :: ruta_html, ruta_css

        ! Asigna rutas para archivos
        ruta_html = "output.html"
        ruta_css = "styles.css"

        ! Llama a las subrutinas para generar los archivos
        CALL escribir_html(ruta_html, ruta_css)
        CALL escribir_css(ruta_css)

        PRINT *, "Archivos generados correctamente: ", ruta_html, " y ", ruta_css

        

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenido_add_array)) then
            print *, "No hay add"
        else
            print *, "add encontrados: ", size(contenido_add_array)
            DO i = 1, size(contenido_add_array)
                print *, 'id: ', trim(contenido_add_array(i)%id)
                print *, 'add: ', trim(contenido_add_array(i)%add)
                print *, '---------------------------------'
            END DO
        end if
    END SUBROUTINE generador_html_css

    SUBROUTINE escribir_html(ruta_html, ruta_css)
        CHARACTER(LEN=*), INTENT(IN) :: ruta_html, ruta_css
        integer :: i, j, k, l, m, n, o, p, a, b, c, d, e, f
        integer :: largo

        OPEN(UNIT=10, FILE=ruta_html, STATUS='REPLACE')
        WRITE(10, '(A)') '<html>'
        WRITE(10, '(A)') '    <head>'
        WRITE(10, '(A)') '        <link rel="stylesheet" type="text/css" href="' // ruta_css // '">'
        WRITE(10, '(A)') '    </head>'
        WRITE(10, '(A)') '    <body>'
        
        ! Fondo principal
        !WRITE(10, '(A)') '        <div id="contFondo" style="width: 800px; height: 100px; background-color: rgb(64,64,64); position: absolute; left: 25px; top: 330px;"></div>'
        
        ! Cuerpo principal que contiene otros elementos
        !WRITE(10, '(A)') '        <div id="ContBody" style="width: 800px; height: 300px; background-color: rgb(64,224,208); position: absolute; left: 23px; top: 21px;">'
        
        do m=1, size(contenido_add_array)
            if (trim(contenido_add_array(m)%id) == "this" .and. trim(contenido_add_array(m)%add) == "contFondo") then
                do n = 1, size(contenedor_array)
                    if (trim(contenedor_array(n)%id) == trim(contenido_add_array(m)%add)) then
                        WRITE(10, '(A)') '        <div id="'// trim(contenedor_array(n)%id) //'" style="width: '// trim(contenedor_array(n)%ancho) //'px; height: '// trim(contenedor_array(n)%alto) //'px; background-color: rgb('// trim(contenedor_array(n)%color_fondo_r) //','// trim(contenedor_array(n)%color_fondo_g) //','// trim(contenedor_array(n)%color_fondo_b) //'); position: absolute; left: '// trim(contenedor_array(n)%posicion_x) //'px; top: '// trim(contenedor_array(n)%posicion_y) //'px;"></div>'
                    end if
                end do
            elseif(trim(contenido_add_array(m)%id) == "this" .and. trim(contenido_add_array(m)%add) == "ContBody") then
                do n = 1, size(contenedor_array)
                    if (trim(contenedor_array(n)%id) == trim(contenido_add_array(m)%add)) then
                        WRITE(10, '(A)') '        <div id="'// trim(contenedor_array(n)%id) //'" style="width: '// trim(contenedor_array(n)%ancho) //'px; height: '// trim(contenedor_array(n)%alto) //'px; background-color: rgb('// trim(contenedor_array(n)%color_fondo_r) //','// trim(contenedor_array(n)%color_fondo_g) //','// trim(contenedor_array(n)%color_fondo_b) //'); position: absolute; left: '// trim(contenedor_array(n)%posicion_x) //'px; top: '// trim(contenedor_array(n)%posicion_y) //'px;"></div>'
                    end if
                end do
            end if
        end do
        
        do m=1, size(contenido_add_array)
            if (trim(contenido_add_array(m)%id) == "ContBody" .and. trim(contenido_add_array(m)%add) == "contlogin") then
                do n = 1, size(contenedor_array)
                    if (trim(contenedor_array(n)%id) == trim(contenido_add_array(m)%add)) then
                        WRITE(10, '(A)') '        <div id="'// trim(contenedor_array(n)%id) //'" style="width: '// trim(contenedor_array(n)%ancho) //'px; height: '// trim(contenedor_array(n)%alto) //'px; background-color: rgb('// trim(contenedor_array(n)%color_fondo_r) //','// trim(contenedor_array(n)%color_fondo_g) //','// trim(contenedor_array(n)%color_fondo_b) //'); position: absolute; left: '// trim(contenedor_array(n)%posicion_x) //'px; top: '// trim(contenedor_array(n)%posicion_y) //'px;">'
                    end if
                end do
            end if
        end do



        !WRITE(10, '(A)') '            <div id="contlogin" style="width: 270px; height: 150px; background-color: rgb(47,79,79); position: absolute; left: 586px; top: 110px;">'
        do i = 1, size(contenido_add_array)
            ! Asegúrate de eliminar espacios en ambas comparaciones
            if (trim(contenido_add_array(i)%id) == "ContBody" .and. trim(contenido_add_array(i)%add) == "contlogin") then
                
                do j = 1, size(contenido_add_array)
                    
                    do k = 1, size(etiqueta_array)
                        if (trim(etiqueta_array(k)%id) == trim(contenido_add_array(j)%add)) then
                            if (trim(contenido_add_array(j)%id) == "contlogin" .and. trim(contenido_add_array(j)%add) == trim(etiqueta_array(k)%id)) then
                                WRITE(10, '(A)') '                <label id="'// trim(contenido_add_array(j)%id) //'" style="width: '// trim(etiqueta_array(k)%ancho) //'px; height: '// trim(etiqueta_array(k)%alto) //'px; color: rgb('// trim(etiqueta_array(k)%color_texto_r) //','// trim(etiqueta_array(k)%color_texto_g) //','// trim(etiqueta_array(k)%color_texto_b) //'); position: absolute; left: '// trim(etiqueta_array(k)%posicion_x) //'px; top: '// trim(etiqueta_array(k)%posicion_y) //'px;">'// quitar_comillas(trim(etiqueta_array(k)%texto)) //'</label>'
                                
                                if (trim(etiqueta_array(k)%id) == "Nombre") then
                                    do l = 1, size(texto_array)
                                        WRITE(10, '(A)') '                <input type="text" id="'// trim(texto_array(l)%id) //'" style="position: absolute; left: '// trim(texto_array(l)%posicion_x) //'px; top: '// trim(texto_array(l)%posicion_y) //'px;" />'
                                    end do
                                elseif (trim(etiqueta_array(k)%id) == "passw") then
                                    do l =1, size(clave_array)
                                        WRITE(10, '(A)') '                <input type="password" id="'// trim(clave_array(l)%id) //'" style="position: absolute; left: '// trim(clave_array(l)%posicion_x) //'px; top: '// trim(clave_array(l)%posicion_y) //'px;" />'
                                    end do
                                elseif (trim(etiqueta_array(k)%id) == "Carnet") then
                                    do l = 1, size(texto_array)
                                        WRITE(10, '(A)') '                <input type="text" id="'// trim(texto_array(l)%id) //'" style="position: absolute; left: '// trim(texto_array(l)%posicion_x) //'px; top: '// trim(texto_array(l)%posicion_y) //'px;" />'
                                    end do  
                                end if 
                            end if
                        end if
                        
                    end do
                    if (trim(contenido_add_array(j)%id) == "contlogin" .and. trim(contenido_add_array(j)%add) == "cmdIngresar") then
                        print *, "comparación correcta para cmdIngresar"
                        WRITE(10, '(A)') '                <button id="'// trim(contenido_add_array(j)%id) //'" style="position: absolute; left: 40px; top: 100px;">Ingresar</button>'
                    end if
                end do
            end if
        end do

        WRITE(10, '(A)') '            </div>'
        
        do p= 1, size(contenido_add_array)
            if (trim(contenido_add_array(p)%id) == "ContBody" .and. trim(contenido_add_array(p)%add) == "contlogo2") then
                do a= 1, size(contenedor_array)
                    if (trim(contenedor_array(a)%id) == trim(contenido_add_array(p)%add)) then
                        WRITE(10, '(A)') '            <div id="'// trim(contenedor_array(a)%id) //'" style="width: '// trim(contenedor_array(a)%ancho) //'px; height: '// trim(contenedor_array(a)%alto) //'px; background-color: rgb('// trim(contenedor_array(a)%color_fondo_r) //','// trim(contenedor_array(a)%color_fondo_g) //','// trim(contenedor_array(a)%color_fondo_b) //'); position: absolute; left: '// trim(contenedor_array(a)%posicion_x) //'px; top: '// trim(contenedor_array(a)%posicion_y) //'px;"></div>'
                    end if 
                
                end do
            elseif (trim(contenido_add_array(p)%id) == "ContBody" .and. trim(contenido_add_array(p)%add) == "ContLogo1") then
                do a= 1, size(contenedor_array)
                    if (trim(contenedor_array(a)%id) == trim(contenido_add_array(p)%add)) then
                        WRITE(10, '(A)') '            <div id="'// trim(contenedor_array(a)%id) //'" style="width: '// trim(contenedor_array(a)%ancho) //'px; height: '// trim(contenedor_array(a)%alto) //'px; background-color: rgb('// trim(contenedor_array(a)%color_fondo_r) //','// trim(contenedor_array(a)%color_fondo_g) //','// trim(contenedor_array(a)%color_fondo_b) //'); position: absolute; left: '// trim(contenedor_array(a)%posicion_x) //'px; top: '// trim(contenedor_array(a)%posicion_y) //'px;"></div>'
                    end if 
                
                end do
            end if
            
        end do
        ! Logo containers
        !WRITE(10, '(A)') '            <div id="contlogo2" style="width: 150px; height: 50px; background-color: rgb(0,128,128); position: absolute; left: 88px; top: 25px;"></div>'
        !WRITE(10, '(A)') '            <div id="ContLogo1" style="width: 50px; height: 50px; background-color: rgb(64,64,64); position: absolute; left: 36px; top: 25px;"></div>'
        
        ! Cierre del body
        WRITE(10, '(A)') '        </div>'  ! Cierra ContBody
        WRITE(10, '(A)') '    </body>'
        WRITE(10, '(A)') '</html>'
        CLOSE(10)
    END SUBROUTINE escribir_html

    SUBROUTINE escribir_css(ruta)
        CHARACTER(LEN=*), INTENT(IN) :: ruta
        integer :: n, b, m

        OPEN(UNIT=11, FILE=ruta, STATUS='REPLACE')

        WRITE(11, '(A)') '/* Estilos generales */'
        WRITE(11, '(A)') '/* Estilos para contFondo */'
        do m=1, size(contenido_add_array)
            if (trim(contenido_add_array(m)%id) == "this" .and. trim(contenido_add_array(m)%add) == "contFondo") then
                do n = 1, size(contenedor_array)
                    if (trim(contenedor_array(n)%id) == trim(contenido_add_array(m)%add)) then
                        WRITE(11, '(A)') '#'// trim(contenedor_array(n)%id) //' {'
                        WRITE(11, '(A)') '    background-color: rgb('// trim(contenedor_array(n)%color_fondo_r) //','// trim(contenedor_array(n)%color_fondo_g) //','// trim(contenedor_array(n)%color_fondo_b) //');'
                        WRITE(11, '(A)') '}'
                    end if
                end do
            end if
        end do
        WRITE(11, '(A)') '/* Estilos para contlogin */'
        do m=1, size(contenido_add_array)
            if (trim(contenido_add_array(m)%id) == "ContBody" .and. trim(contenido_add_array(m)%add) == "contlogin") then
                do n = 1, size(contenedor_array)
                    if (trim(contenedor_array(n)%id) == trim(contenido_add_array(m)%add)) then
                        WRITE(11, '(A)') '#'// trim(contenedor_array(n)%id) //' {'
                        WRITE(11, '(A)') '    background-color: rgb('// trim(contenedor_array(n)%color_fondo_r) //','// trim(contenedor_array(n)%color_fondo_g) //','// trim(contenedor_array(n)%color_fondo_b) //');'
                        WRITE(11, '(A)') '}'
                    end if
                end do
            end if
        end do
        ! WRITE(11, '(A)') '/* Estilos generales */'
        ! WRITE(11, '(A)') '/* Estilos para contFondo */'
        ! WRITE(11, '(A)') '#contFondo {'
        ! WRITE(11, '(A)') '    background-color: rgb(64, 64, 64);'
        ! WRITE(11, '(A)') '}'
        ! WRITE(11, '(A)') '/* Estilos para contlogin */'
        ! WRITE(11, '(A)') '#contlogin {'
        ! WRITE(11, '(A)') '    background-color: rgb(47, 79, 79);'
        ! WRITE(11, '(A)') '}'
        do b=1, size(etiqueta_array)
            if (trim(etiqueta_array(b)%id) == "Nombre") then
                WRITE(11, '(A)') '#'// trim(etiqueta_array(b)%id) //' {'
                WRITE(11, '(A)') '    color: rgb('// trim(etiqueta_array(b)%color_texto_r) //','// trim(etiqueta_array(b)%color_texto_g) //','// trim(etiqueta_array(b)%color_texto_b) //');'
                WRITE(11, '(A)') '}'
            else if (trim(etiqueta_array(b)%id) == "passw") then
                WRITE(11, '(A)') '#'// trim(etiqueta_array(b)%id) //' {'
                WRITE(11, '(A)') '    color: rgb('// trim(etiqueta_array(b)%color_texto_r) //','// trim(etiqueta_array(b)%color_texto_g) //','// trim(etiqueta_array(b)%color_texto_b) //');'
                WRITE(11, '(A)') '}'
            end if
        end do
        ! WRITE(11, '(A)') '#Nombre {'
        ! WRITE(11, '(A)') '    color: rgb(128, 128, 128);'
        ! WRITE(11, '(A)') '}'
        ! WRITE(11, '(A)') '#passw {'
        ! WRITE(11, '(A)') '    color: rgb(128, 128, 128);'
        ! WRITE(11, '(A)') '}'
        CLOSE(11)
    END SUBROUTINE escribir_css

    function quitar_comillas(texto) result(texto_sin_comillas)
        character(len=*), intent(in) :: texto
        character(len=len(texto)) :: texto_sin_comillas

        texto_sin_comillas = texto
        texto_sin_comillas = adjustl(texto_sin_comillas)  ! Asegura que no haya espacios
        if (len_trim(texto_sin_comillas) >= 2) then
            if (texto_sin_comillas(1:1) == '"' .and. texto_sin_comillas(len_trim(texto_sin_comillas):len_trim(texto_sin_comillas)) == '"') then
                texto_sin_comillas = texto_sin_comillas(2:len_trim(texto_sin_comillas)-1)
            end if
        end if
    end function

END MODULE generador_mod