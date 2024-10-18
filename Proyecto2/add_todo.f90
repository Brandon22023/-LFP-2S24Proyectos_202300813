MODULE add_todo
    implicit none
    type :: contenido_add
        CHARACTER(LEN = 50) :: id
        CHARACTER(LEN = 100) :: add
    end type contenido_add
    type(contenido_add), ALLOCATABLE :: contenido_add_array(:)
contains
    subroutine contenedor_set_add(id, add)
        CHARACTER(LEN=*), INTENT(IN) :: id, add
        integer :: n
        type(contenido_add), ALLOCATABLE :: temp_array(:)  ! Arreglo temporal

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(contenido_add_array)) then
            ! Si no hay elementos en el arreglo, inicializa y agrega el primer elemento
            ALLOCATE(contenido_add_array(1))
            contenido_add_array(1)%id = id
            contenido_add_array(1)%add = add
        else
            ! Si el arreglo ya tiene elementos, guarda su tamaño actual
            n = size(contenido_add_array)

            ! Crea un arreglo temporal para almacenar los elementos actuales
            ALLOCATE(temp_array(n))
            temp_array = contenido_add_array  ! Copia los elementos existentes al arreglo temporal

            ! Redimensiona el arreglo original para agregar un nuevo elemento
            DEALLOCATE(contenido_add_array)
            ALLOCATE(contenido_add_array(n + 1))

            ! Copia los datos del arreglo temporal de vuelta al arreglo original
            contenido_add_array(:n) = temp_array
            contenido_add_array(n + 1)%id = id  ! Añade el nuevo elemento
            contenido_add_array(n + 1)%add = add

            ! Libera el arreglo temporal
            DEALLOCATE(temp_array)
        end if
    end subroutine contenedor_set_add

    subroutine imprimir_add()
        integer :: i

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

    end subroutine imprimir_add
end module add_todo