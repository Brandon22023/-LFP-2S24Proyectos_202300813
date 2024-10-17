MODULE texto
    implicit none

    type :: Tag
        CHARACTER(LEN = 50) :: id
        CHARACTER(LEN = 20) :: tipo
        CHARACTER(LEN = 200) :: texto
        CHARACTER(LEN = 50) :: posicion_x
        CHARACTER(LEN = 50) :: posicion_y
    End type Tag

    ! Declaración de un arreglo de Tag para almacenar los textos
    type(Tag), ALLOCATABLE ::  texto_array(:)
    

contains

    ! Subrutina para agregar textos a la lista de texto
    subroutine agregar_texto(id )
        CHARACTER(LEN=*), INTENT(IN) :: id

        type(Tag) :: nuevo_texto
        integer :: n
        type(Tag), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo texto
        nuevo_texto%id = id
        nuevo_texto%tipo = 'texto'
        nuevo_texto%texto = ""
        nuevo_texto%posicion_x = ""
        nuevo_texto%posicion_y = ""


        ! Agrego el nuevo texto a la lista de textos
        if (.NOT. ALLOCATED(texto_array)) then !Si esta vacia
            ALLOCATE(texto_array(1)) ! Se le asigna memoria para un texto de la lista
            texto_array(1) =  nuevo_texto !Se convierte en el texto nuevo
        else
            n = size(texto_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = texto_array !Reservo memoria
            temp_array(n+1) = nuevo_texto
            DEALLOCATE(texto_array) !Libero memoria
            ALLOCATE(texto_array(n+1)) !Reservo memoria de nuevo
            texto_array = temp_array
        end if
    end subroutine agregar_texto

    subroutine imprimir_textos()

    integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(texto_array)) then
            print *, "No hay textoes"
        else
            print *, "textos encontrados: ", size(texto_array)
            DO i = 1, size(texto_array)
                print *, 'id: ', trim(texto_array(i)%id)
                print *, 'texto: ', trim(texto_array(i)%texto)
                print *, 'posicion_x: ', trim(texto_array(i)%posicion_x)
                print *, 'posicion_y: ', trim(texto_array(i)%posicion_y)
                print *, '---------------------------------'
            END DO
        end if

    end subroutine imprimir_textos

    ! Subrutina para buscar una texto por su id

    subroutine texto_set_texto(id, texto)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: texto
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(texto_array)) then
            print *, "No hay textos"
        else
            DO i = 1, size(texto_array)
                if (trim(texto_array(i)%id) == id) then
                    texto_array(i)%texto = texto
                end if
            END DO
        end if

    end subroutine texto_set_texto

    subroutine texto_set_posicion(id, posicion_x, posicion_y)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: posicion_x
        CHARACTER(LEN=*), INTENT(IN) :: posicion_y
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(texto_array)) then
            print *, "No hay textos"
        else
            DO i = 1, size(texto_array)
                if (trim(texto_array(i)%id) == id) then
                    texto_array(i)%posicion_x = posicion_x
                    texto_array(i)%posicion_y = posicion_y
                end if
            END DO
        end if

    end subroutine texto_set_posicion

    ! Función para buscar una texto por su ID
    FUNCTION buscar_texto_por_id(id) RESULT(encontrado)
        CHARACTER(LEN=*), INTENT(IN) :: id
        logical :: encontrado
        integer :: i

        encontrado = .FALSE.

        if (.NOT. ALLOCATED(texto_array)) then
            print *, "No hay textos"
        else
            DO i = 1, size(texto_array)
                if (trim(texto_array(i)%id) == trim(id)) then
                    encontrado = .TRUE.
                    return
                end if
            END DO
        end if
    END FUNCTION buscar_texto_por_id

END MODULE texto