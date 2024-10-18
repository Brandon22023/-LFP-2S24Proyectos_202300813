MODULE generador_mod
    USE contenedor
    USE add_todo
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
        integer :: i, j, k, l, m, n, o, p
        integer :: largo

        OPEN(UNIT=10, FILE=ruta_html, STATUS='REPLACE')
        WRITE(10, '(A)') '<html>'
        WRITE(10, '(A)') '    <head>'
        WRITE(10, '(A)') '        <link rel="stylesheet" type="text/css" href="' // ruta_css // '">'
        WRITE(10, '(A)') '    </head>'
        WRITE(10, '(A)') '    <body>'
        
        ! Fondo principal
        WRITE(10, '(A)') '        <div id="contFondo" style="width: 800px; height: 100px; background-color: rgb(64,64,64); position: absolute; left: 25px; top: 330px;"></div>'
        
        ! Cuerpo principal que contiene otros elementos
        WRITE(10, '(A)') '        <div id="ContBody" style="width: 800px; height: 300px; background-color: rgb(64,224,208); position: absolute; left: 23px; top: 21px;">'
        

       
        
        ! Login container y sus elementos
        WRITE(10, '(A)') '            <div id="contlogin" style="width: 270px; height: 150px; background-color: rgb(47,79,79); position: absolute; left: 586px; top: 110px;">'
        do i = 1, size(contenido_add_array)
            ! Imprimir los valores que se están comparando
            print *, "Comparando ID: ", trim(contenido_add_array(i)%id), " con 'this'"
            print *, "Comparando ADD: ", trim(contenido_add_array(i)%add), " con 'contlogin'"
            ! Asegúrate de eliminar espacios en ambas comparaciones
            if (trim(contenido_add_array(i)%id) == "ContBody" .and. trim(contenido_add_array(i)%add) == "contlogin") then
            

                do j = 1, size(contenido_add_array)
                    
                    do k = 1, size(etiqueta_array)
                        if (trim(etiqueta_array(k)%id) == trim(contenido_add_array(j)%idd)) then
                            if (trim(contenido_add_array(j)%id) == "contlogin" .and. trim(contenido_add_array(j)%add) == trim(etiqueta_array(k)%id)) then
                                WRITE(10, '(A)') '                <label id="'// trim(contenido_add_array(j)%id) //'" style="width: 44px; height: 13px; color: rgb(128,128,128); position: absolute; left: 8px; top: 21px;">Nombre</label>'
                                WRITE(10, '(A)') '                <input type="text" id="Texto0" style="position: absolute; left: 65px; top: 20px;" />'
                            end if
                            
                            if (trim(contenido_add_array(j)%id) == "contlogin" .and. trim(contenido_add_array(j)%add) == "passw") then
                                WRITE(10, '(A)') '                <label id="'// trim(contenido_add_array(j)%id) //'" style="width: 53px; height: 13px; color: rgb(128,128,128); position: absolute; left: 11px; top: 54px;">Password</label>'
                                WRITE(10, '(A)') '                <input type="password" id="pswClave" style="position: absolute; left: 67px; top: 48px;" />'
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

        ! Logo containers
        WRITE(10, '(A)') '            <div id="contlogo2" style="width: 150px; height: 50px; background-color: rgb(0,128,128); position: absolute; left: 88px; top: 25px;"></div>'
        WRITE(10, '(A)') '            <div id="ContLogo1" style="width: 50px; height: 50px; background-color: rgb(64,64,64); position: absolute; left: 36px; top: 25px;"></div>'
        
        ! Cierre del body
        WRITE(10, '(A)') '        </div>'  ! Cierra ContBody
        WRITE(10, '(A)') '    </body>'
        WRITE(10, '(A)') '</html>'
        CLOSE(10)
    END SUBROUTINE escribir_html

    SUBROUTINE escribir_css(ruta)
        CHARACTER(LEN=*), INTENT(IN) :: ruta

        OPEN(UNIT=11, FILE=ruta, STATUS='REPLACE')
        WRITE(11, '(A)') '/* Estilos generales */'
        WRITE(11, '(A)') '/* Estilos para contFondo */'
        WRITE(11, '(A)') '#contFondo {'
        WRITE(11, '(A)') '    background-color: rgb(64, 64, 64);'
        WRITE(11, '(A)') '}'
        WRITE(11, '(A)') '/* Estilos para contlogin */'
        WRITE(11, '(A)') '#contlogin {'
        WRITE(11, '(A)') '    background-color: rgb(47, 79, 79);'
        WRITE(11, '(A)') '}'
        WRITE(11, '(A)') '#Nombre {'
        WRITE(11, '(A)') '    color: rgb(128, 128, 128);'
        WRITE(11, '(A)') '}'
        WRITE(11, '(A)') '#passw {'
        WRITE(11, '(A)') '    color: rgb(128, 128, 128);'
        WRITE(11, '(A)') '}'
        WRITE(11, '(A)') '#cmdIngresar {'
        WRITE(11, '(A)') '    margin-top: 20px;'
        WRITE(11, '(A)') '}'
        CLOSE(11)
    END SUBROUTINE escribir_css

END MODULE generador_mod