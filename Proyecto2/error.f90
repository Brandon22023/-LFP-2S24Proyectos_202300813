MODULE error
    implicit none

    type :: Err
        CHARACTER(LEN = 100) :: ultimo_token
        CHARACTER(LEN = 100) :: token_esperado 
        integer :: fila
        integer:: columna
    End type Err

    ! Declaración de un arreglo de Err para almacenar los errores
    type(Err), ALLOCATABLE ::  error_array(:)

contains 

    ! Subrutina para agregar errores a la lista de error
    subroutine agregar_error(ultimo_token, token_esperado, fila, columna)
        CHARACTER(LEN=*), INTENT(IN) :: ultimo_token
        CHARACTER(LEN=*), INTENT(IN) :: token_esperado
        integer :: fila
        integer :: columna
        type(Err) :: nuevo_error
        integer :: n
        type(Err), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo error
        nuevo_error%ultimo_token = ultimo_token
        nuevo_error%token_esperado = token_esperado
        nuevo_error%fila = fila
        nuevo_error%columna = columna

        ! Agrego el nuevo error a la lista de errores
        if (.NOT. ALLOCATED(error_array)) then !Si esta vacia
            ALLOCATE(error_array(1)) ! Se le asigna memoria para un error de la lista
            error_array(1) =  nuevo_error !Se convierte en el error nuevo
        else
            n = size(error_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = error_array !Reservo memoria
            temp_array(n+1) = nuevo_error
            DEALLOCATE(error_array) !Libero memoria
            ALLOCATE(error_array(n+1)) !Reservo memoria de nuevo
            error_array = temp_array
        end if
    end subroutine agregar_error

    ! Subrutina para imprimir los errores en consola
    subroutine imprimir_errores()
        integer :: i !Contador del bucle
        character(len=20) :: str_fila, str_columna
        
        if (.NOT. ALLOCATED(error_array)) then
                print *, "No hay errores"
            else
                DO i = 1, size(error_array)

                    write(str_fila, '(I0)') error_array(i)%fila
                    write(str_columna, '(I0)') error_array(i)%columna
                    print *, 'Error Sintactico: '
                    print *, 'Ultimo Token: ', trim(error_array(i)%ultimo_token)
                    print *, 'Token Esperado: ', trim(error_array(i)%token_esperado)
                    print *, 'Fila: ', trim(str_fila)
                    print *, 'Columna: ', trim(str_columna)
                END DO
        end if

    end subroutine imprimir_errores
    
END MODULE error        