MODULE etiqueta
    implicit none

    type :: Tag
        CHARACTER(LEN = 50) :: id
        CHARACTER(LEN = 20) :: tipo
        CHARACTER(LEN = 20) :: alto
        CHARACTER(LEN = 20) :: ancho
        CHARACTER(LEN = 200) :: texto
        CHARACTER(LEN = 50) :: color_texto_r
        CHARACTER(LEN = 50) :: color_texto_g
        CHARACTER(LEN = 50) :: color_texto_b
        CHARACTER(LEN = 50) :: posicion_x
        CHARACTER(LEN = 50) :: posicion_y
    End type Tag

    ! Declaración de un arreglo de Tag para almacenar los etiquetas
    type(Tag), ALLOCATABLE ::  etiqueta_array(:)
    

contains

    ! Subrutina para agregar etiquetas a la lista de etiqueta
    subroutine agregar_etiqueta(id )
        CHARACTER(LEN=*), INTENT(IN) :: id

        type(Tag) :: nuevo_etiqueta
        integer :: n
        type(Tag), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo etiqueta
        nuevo_etiqueta%id = id
        nuevo_etiqueta%tipo = 'Etiqueta'
        nuevo_etiqueta%alto = ""
        nuevo_etiqueta%ancho = ""
        nuevo_etiqueta%texto = ""
        nuevo_etiqueta%color_texto_r = ""
        nuevo_etiqueta%color_texto_g = ""
        nuevo_etiqueta%color_texto_b = ""
        nuevo_etiqueta%posicion_x = ""
        nuevo_etiqueta%posicion_y = ""


        ! Agrego el nuevo etiqueta a la lista de etiquetas
        if (.NOT. ALLOCATED(etiqueta_array)) then !Si esta vacia
            ALLOCATE(etiqueta_array(1)) ! Se le asigna memoria para un etiqueta de la lista
            etiqueta_array(1) =  nuevo_etiqueta !Se convierte en el etiqueta nuevo
        else
            n = size(etiqueta_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = etiqueta_array !Reservo memoria
            temp_array(n+1) = nuevo_etiqueta
            DEALLOCATE(etiqueta_array) !Libero memoria
            ALLOCATE(etiqueta_array(n+1)) !Reservo memoria de nuevo
            etiqueta_array = temp_array
        end if
    end subroutine agregar_etiqueta

    subroutine imprimir_etiquetas()

    integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            print *, "etiquetas encontrados: ", size(etiqueta_array)
            DO i = 1, size(etiqueta_array)
                print *, 'id: ', trim(etiqueta_array(i)%id)
                print *, 'alto: ', trim(etiqueta_array(i)%alto)
                print *, 'ancho: ', trim(etiqueta_array(i)%ancho)
                print *, 'texto: ', trim(etiqueta_array(i)%texto)
                print *, 'color_texto_r: ', trim(etiqueta_array(i)%color_texto_r)
                print *, 'color_texto_g: ', trim(etiqueta_array(i)%color_texto_g)
                print *, 'color_texto_b: ', trim(etiqueta_array(i)%color_texto_b)
                print *, 'posicion_x: ', trim(etiqueta_array(i)%posicion_x)
                print *, 'posicion_y: ', trim(etiqueta_array(i)%posicion_y)
                print *, '---------------------------------'
            END DO
        end if

    end subroutine imprimir_etiquetas

    ! Subrutina para buscar una etiqueta por su id
    subroutine etiqueta_set_alto(id, alto)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: alto
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == id) then
                    etiqueta_array(i)%alto = alto
                end if
            END DO
        end if

    end subroutine etiqueta_set_alto

    subroutine etiqueta_set_ancho(id, ancho)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: ancho
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == id) then
                    etiqueta_array(i)%ancho = ancho
                end if
            END DO
        end if

    end subroutine etiqueta_set_ancho

    subroutine etiqueta_set_texto(id, texto)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: texto
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == id) then
                    etiqueta_array(i)%texto = texto
                end if
            END DO
        end if

    end subroutine etiqueta_set_texto

    subroutine etiqueta_set_color_texto(id, color_texto_r, color_texto_g, color_texto_b)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: color_texto_r
        CHARACTER(LEN=*), INTENT(IN) :: color_texto_g
        CHARACTER(LEN=*), INTENT(IN) :: color_texto_b
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == id) then
                    etiqueta_array(i)%color_texto_r = color_texto_r
                    etiqueta_array(i)%color_texto_g = color_texto_g
                    etiqueta_array(i)%color_texto_b = color_texto_b
                end if
            END DO
        end if

    end subroutine etiqueta_set_color_texto

    subroutine etiqueta_set_posicion(id, posicion_x, posicion_y)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: posicion_x
        CHARACTER(LEN=*), INTENT(IN) :: posicion_y
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == id) then
                    etiqueta_array(i)%posicion_x = posicion_x
                    etiqueta_array(i)%posicion_y = posicion_y
                end if
            END DO
        end if

    end subroutine etiqueta_set_posicion

    ! Función para buscar una etiqueta por su ID
    FUNCTION buscar_etiqueta_por_id(id) RESULT(encontrado)
        CHARACTER(LEN=*), INTENT(IN) :: id
        logical :: encontrado
        integer :: i

        encontrado = .FALSE.

        if (.NOT. ALLOCATED(etiqueta_array)) then
            print *, "No hay etiquetas"
        else
            DO i = 1, size(etiqueta_array)
                if (trim(etiqueta_array(i)%id) == trim(id)) then
                    encontrado = .TRUE.
                    return
                end if
            END DO
        end if
    END FUNCTION buscar_etiqueta_por_id

END MODULE etiqueta






