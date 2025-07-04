MODULE contenedor
    implicit none

    type :: Tag
        CHARACTER(LEN = 5000) :: id
        CHARACTER(LEN = 2000) :: tipo
        CHARACTER(LEN = 2000) :: alto
        CHARACTER(LEN = 2000) :: ancho
        CHARACTER(LEN = 2000) :: fondo
        CHARACTER(LEN = 5000) :: color_fondo_r
        CHARACTER(LEN = 5000) :: color_fondo_g
        CHARACTER(LEN = 5000) :: color_fondo_b
        CHARACTER(LEN = 5000) :: posicion_x
        CHARACTER(LEN = 5000) :: posicion_y
    End type Tag

    ! Declaración de un arreglo de Tag para almacenar los contenedores
    type(Tag), ALLOCATABLE ::  contenedor_array(:)
    

contains

    ! Subrutina para agregar contenedors a la lista de contenedor
    subroutine agregar_contenedor(id )
        CHARACTER(LEN=*), INTENT(IN) :: id

        type(Tag) :: nuevo_contenedor
        integer :: n
        type(Tag), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo contenedor
        nuevo_contenedor%id = id
        nuevo_contenedor%tipo = 'contenedor'
        nuevo_contenedor%alto = ""
        nuevo_contenedor%ancho = ""
        nuevo_contenedor%fondo = ""
        nuevo_contenedor%color_fondo_r = ""
        nuevo_contenedor%color_fondo_g = ""
        nuevo_contenedor%color_fondo_b = ""
        nuevo_contenedor%posicion_x = ""
        nuevo_contenedor%posicion_y = ""


        ! Agrego el nuevo contenedor a la lista de contenedors
        if (.NOT. ALLOCATED(contenedor_array)) then !Si esta vacia
            ALLOCATE(contenedor_array(1)) ! Se le asigna memoria para un contenedor de la lista
            contenedor_array(1) =  nuevo_contenedor !Se convierte en el contenedor nuevo
        else
            n = size(contenedor_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = contenedor_array !Reservo memoria
            temp_array(n+1) = nuevo_contenedor
            DEALLOCATE(contenedor_array) !Libero memoria
            ALLOCATE(contenedor_array(n+1)) !Reservo memoria de nuevo
            contenedor_array = temp_array
        end if
    end subroutine agregar_contenedor

    subroutine imprimir_contenedores()

    integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedores"
        else
            print *, "contenedores encontrados: ", size(contenedor_array)
            DO i = 1, size(contenedor_array)
                print *, 'id: ', trim(contenedor_array(i)%id)
                print *, 'alto: ', trim(contenedor_array(i)%alto)
                print *, 'ancho: ', trim(contenedor_array(i)%ancho)
                print *, 'color_fondo_r: ', trim(contenedor_array(i)%color_fondo_r)
                print *, 'color_fondo_g: ', trim(contenedor_array(i)%color_fondo_g)
                print *, 'color_fondo_b: ', trim(contenedor_array(i)%color_fondo_b)
                print *, 'posicion_x: ', trim(contenedor_array(i)%posicion_x)
                print *, 'posicion_y: ', trim(contenedor_array(i)%posicion_y)
                print *, '---------------------------------'
            END DO
        end if

    end subroutine imprimir_contenedores

    ! Subrutina para buscar una contenedor por su id
    subroutine contenedor_set_alto(id, alto)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: alto
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedors"
        else
            DO i = 1, size(contenedor_array)
                if (trim(contenedor_array(i)%id) == id) then
                    contenedor_array(i)%alto = alto
                end if
            END DO
        end if

    end subroutine                 

    subroutine contenedor_set_ancho(id, ancho)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: ancho
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedors"
        else
            DO i = 1, size(contenedor_array)
                if (trim(contenedor_array(i)%id) == id) then
                    contenedor_array(i)%ancho = ancho
                end if
            END DO
        end if

    end subroutine contenedor_set_ancho

    subroutine contenedor_set_color_fondo(id, color_fondo_r, color_fondo_g, color_fondo_b)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: color_fondo_r
        CHARACTER(LEN=*), INTENT(IN) :: color_fondo_g
        CHARACTER(LEN=*), INTENT(IN) :: color_fondo_b
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedors"
        else
            DO i = 1, size(contenedor_array)
                if (trim(contenedor_array(i)%id) == id) then
                    contenedor_array(i)%color_fondo_r = color_fondo_r
                    contenedor_array(i)%color_fondo_g = color_fondo_g
                    contenedor_array(i)%color_fondo_b = color_fondo_b
                end if
            END DO
        end if

    end subroutine contenedor_set_color_fondo

    subroutine contenedor_set_posicion(id, posicion_x, posicion_y)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: posicion_x
        CHARACTER(LEN=*), INTENT(IN) :: posicion_y
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedors"
        else
            DO i = 1, size(contenedor_array)
                if (trim(contenedor_array(i)%id) == id) then
                    contenedor_array(i)%posicion_x = posicion_x
                    contenedor_array(i)%posicion_y = posicion_y
                end if
            END DO
        end if

    end subroutine contenedor_set_posicion

    ! Función para buscar una contenedor por su ID
    FUNCTION buscar_contenedor_por_id(id) RESULT(encontrado)
        CHARACTER(LEN=*), INTENT(IN) :: id
        logical :: encontrado
        integer :: i

        encontrado = .FALSE.

        if (.NOT. ALLOCATED(contenedor_array)) then
            print *, "No hay contenedors"
        else
            DO i = 1, size(contenedor_array)
                if (trim(contenedor_array(i)%id) == trim(id)) then
                    encontrado = .TRUE.
                    return
                end if
            END DO
        end if
    END FUNCTION buscar_contenedor_por_id

END MODULE contenedor