MODULE error_lexico
    implicit none

    type :: Err
        CHARACTER(LEN = 10000) :: ultimo_token
        CHARACTER(LEN = 10000) :: token_esperado 
        integer :: fila
        integer:: columna
    End type Err

    ! Declaración de un arreglo de Err para almacenar los errores
    type(Err), ALLOCATABLE ::  error_array(:)

contains 

    ! Subrutina para agregar errores a la lista de error
    subroutine agregar_error_lexico(ultimo_token, token_esperado, fila, columna)
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
    end subroutine agregar_error_lexico

    ! Subrutina para imprimir los errores en consola
    subroutine imprimir_errores_lexico()
        integer :: i !Contador del bucle
        character(len=20) :: str_fila, str_columna
        
        if (.NOT. ALLOCATED(error_array)) then
                print *, "No hay errores"
            else
                DO i = 1, size(error_array)

                    write(str_fila, '(I0)') error_array(i)%fila
                    write(str_columna, '(I0)') error_array(i)%columna
                    print *, 'Error lexico: '
                    print *, 'Fila: ', trim(str_fila)
                    print *, 'Columna: ', trim(str_columna)
                    print *, 'Ultimo Token: ', trim(error_array(i)%ultimo_token)
                    print *, 'Mensjae de error: ', trim(error_array(i)%token_esperado)
                    
                END DO
        end if

    end subroutine imprimir_errores_lexico
        subroutine escribir_errores_lexico_txt()
        integer :: i
        integer :: unidad = 10  ! Asignamos una unidad explícita
        integer :: iostat
        character(len=20) :: str_fila, str_columna
        character(len=200) :: line_error
        character(len=200) :: ruta_archivo

        ! Ruta del archivo en el que se agregarán los errores
        ruta_archivo = "C:\Users\Marro\Documents\yon\CUARTO SEMESTRE\LAB LENGUAJES FORMALES\-LFP-2S24Proyectos_202300813\Proyecto2\TODOS_LOS_ERRORES.txt"

        ! Abrir el archivo para escribir en modo apéndice
        open(unit=unidad, file=trim(ruta_archivo), status='old', action='write', position='append', iostat=iostat)
        if (iostat /= 0) then
            print *, "Error al abrir el archivo para escribir. Código de error: ", iostat
            return
        end if

        ! Solo escribir si hay errores en error_array
        if (ALLOCATED(error_array)) then
            DO i = 1, size(error_array)
                ! Convertir fila y columna a string
                write(str_fila, '(I0)') error_array(i)%fila
                write(str_columna, '(I0)') error_array(i)%columna

                ! Combinar todos los valores del error en una sola cadena
                line_error = "Lexico, " // trim(str_fila) // ", " // trim(str_columna) // ", " // &
                            trim(error_array(i)%ultimo_token ) // ", " // trim(error_array(i)%token_esperado)

                ! Escribir la cadena completa en una línea
                write(unidad, '(A)') trim(line_error)
            END DO
        end if

        ! Cerrar el archivo
        close(unidad)
    end subroutine escribir_errores_lexico_txt

    
END MODULE error_lexico       