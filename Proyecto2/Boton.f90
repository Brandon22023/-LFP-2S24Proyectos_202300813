MODULE Boton
    implicit none

    type :: Tag
        CHARACTER(LEN = 5000) :: id
        CHARACTER(LEN = 2000) :: tipo
        CHARACTER(LEN = 20000) :: texto
        CHARACTER(LEN = 5000) :: posicion_x
        CHARACTER(LEN = 5000) :: posicion_y
    End type Tag

    ! Declaración de un arreglo de Tag para almacenar los Botons
    type(Tag), ALLOCATABLE ::  Boton_array(:)
    

contains

    ! Subrutina para agregar Botons a la lista de Boton
    subroutine agregar_Boton(id )
        CHARACTER(LEN=*), INTENT(IN) :: id

        type(Tag) :: nuevo_Boton
        integer :: n
        type(Tag), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo Boton
        nuevo_Boton%id = id
        nuevo_Boton%tipo = 'Boton'
        nuevo_Boton%texto = ""
        nuevo_Boton%posicion_x = ""
        nuevo_Boton%posicion_y = ""


        ! Agrego el nuevo Boton a la lista de Botons
        if (.NOT. ALLOCATED(Boton_array)) then !Si esta vacia
            ALLOCATE(Boton_array(1)) ! Se le asigna memoria para un Boton de la lista
            Boton_array(1) =  nuevo_Boton !Se convierte en el Boton nuevo
        else
            n = size(Boton_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = Boton_array !Reservo memoria
            temp_array(n+1) = nuevo_Boton
            DEALLOCATE(Boton_array) !Libero memoria
            ALLOCATE(Boton_array(n+1)) !Reservo memoria de nuevo
            Boton_array = temp_array
        end if
    end subroutine agregar_Boton

    subroutine imprimir_Botons()

    integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(Boton_array)) then
            print *, "No hay Botones"
        else
            print *, "Botons encontrados: ", size(Boton_array)
            DO i = 1, size(Boton_array)
                print *, 'id: ', trim(Boton_array(i)%id)
                print *, 'texto: ', trim(Boton_array(i)%texto)
                print *, 'posicion_x: ', trim(Boton_array(i)%posicion_x)
                print *, 'posicion_y: ', trim(Boton_array(i)%posicion_y)
                print *, '---------------------------------'
            END DO
        end if

    end subroutine imprimir_Botons

    ! Subrutina para buscar una Boton por su id

    subroutine Boton_set_texto(id, texto)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: texto
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(Boton_array)) then
            print *, "No hay Botons"
        else
            DO i = 1, size(Boton_array)
                if (trim(Boton_array(i)%id) == id) then
                    Boton_array(i)%texto = texto
                end if
            END DO
        end if

    end subroutine Boton_set_texto

    subroutine Boton_set_posicion(id, posicion_x, posicion_y)
        CHARACTER(LEN=*), INTENT(IN) :: id
        CHARACTER(LEN=*), INTENT(IN) :: posicion_x
        CHARACTER(LEN=*), INTENT(IN) :: posicion_y
        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(Boton_array)) then
            print *, "No hay Botons"
        else
            DO i = 1, size(Boton_array)
                if (trim(Boton_array(i)%id) == id) then
                    Boton_array(i)%posicion_x = posicion_x
                    Boton_array(i)%posicion_y = posicion_y
                end if
            END DO
        end if

    end subroutine Boton_set_posicion

    ! Función para buscar una Boton por su ID
    FUNCTION buscar_Boton_por_id(id) RESULT(encontrado)
        CHARACTER(LEN=*), INTENT(IN) :: id
        logical :: encontrado
        integer :: i

        encontrado = .FALSE.

        if (.NOT. ALLOCATED(Boton_array)) then
            print *, "No hay Botons"
        else
            DO i = 1, size(Boton_array)
                if (trim(Boton_array(i)%id) == trim(id)) then
                    encontrado = .TRUE.
                    return
                end if
            END DO
        end if
    END FUNCTION buscar_Boton_por_id

END MODULE Boton