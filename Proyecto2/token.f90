MODULE token
    use error
    use etiqueta
    implicit none

    type :: Tkn
        CHARACTER(LEN = 100) :: lexema
        CHARACTER(LEN = 200) :: tipo 
        integer :: fila
        integer :: columna
    End type Tkn

    ! Declaración de un arreglo de Tkn para almacenar los tokens
    type(Tkn), ALLOCATABLE ::  token_array(:)
    

contains

    ! Subrutina para agregar tokens a la lista de token
    subroutine agregar_token(lexema, tipo, fila, columna)
        CHARACTER(LEN=*), INTENT(IN) :: lexema
        CHARACTER(LEN=*), INTENT(IN) :: tipo
        integer :: fila
        integer :: columna
        type(Tkn) :: nuevo_token
        integer :: n
        type(Tkn), ALLOCATABLE ::  temp_array(:)
        
        !Inicializo los datos del nuevo token
        nuevo_token%lexema = lexema
        nuevo_token%tipo = tipo
        nuevo_token%fila = fila
        nuevo_token%columna = columna

        ! Agrego el nuevo token a la lista de tokens
        if (.NOT. ALLOCATED(token_array)) then !Si esta vacia
            ALLOCATE(token_array(1)) ! Se le asigna memoria para un token de la lista
            token_array(1) =  nuevo_token !Se convierte en el token nuevo
        else
            n = size(token_array)
            ALLOCATE(temp_array(n+1))
            temp_array(:n) = token_array !Reservo memoria
            temp_array(n+1) = nuevo_token
            DEALLOCATE(token_array) !Libero memoria
            ALLOCATE(token_array(n+1)) !Reservo memoria de nuevo
            token_array = temp_array
        end if
    end subroutine agregar_token

    ! Subrutina para imprimir el listado de tokens en html
    subroutine imprimir_tokens()
        integer :: i
        character(len=20) :: str_fila, str_columna

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(token_array)) then
            print *, "No hay tokens"
        else
            print *, "tokens encontrados: ", size(token_array)
            ! Recorre la lista de tokens y genera una fila para cada token
            DO i = 1, size(token_array)

                write(str_fila, '(I0)') token_array(i)%fila
                write(str_columna, '(I0)') token_array(i)%columna
            
                print *, 'lexema: ', trim(token_array(i)%lexema)
                print *, 'tipo: ', trim(token_array(i)%tipo)
                print *, 'fila: ', trim(str_fila)
                print *, 'columna: ', trim(str_columna)
                print *, '---------------------------------'
            END DO
        end if

    end subroutine imprimir_tokens

    subroutine generar_html_tokens()
        character(len=100000) :: html_content
        character(len=100) :: str_tipo, str_columna, str_fila, char_token
        integer :: file_unit, ios, i

        ! Verifica si la memoria ha sido asignada para el arreglo de tokens
        if (.NOT. ALLOCATED(token_array)) then
            print *, "No hay tokens disponibles para generar HTML."
        else
            ! Abrir el archivo para escribir
            open(unit=file_unit, file="tokens.html", status="replace", action="write", iostat=ios)
            if (ios /= 0) then
                print *, "Error al crear el archivo HTML."
            else
                ! Escribir la cabecera del HTML directamente al archivo
                write(file_unit, '(A)') '<!DOCTYPE html>' // new_line('a')
                write(file_unit, '(A)') '<html><head><style>' // new_line('a')
                write(file_unit, '(A)') 'table { font-family: Arial, sans-serif;'
                write(file_unit, '(A)') 'border-collapse: collapse; width: 100%; }' // new_line('a')
                write(file_unit, '(A)') 'td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; }' // new_line('a')
                write(file_unit, '(A)') 'tr:nth-child(even) { background-color: #f2f2f2; }' // new_line('a')
                write(file_unit, '(A)') '</style></head><body><h2>Tabla de Tokens</h2>' // new_line('a')
                write(file_unit, '(A)') '<table><tr><th>Lexema</th><th>Tipo</th><th>Columna</th><th>Fila</th></tr>' // new_line('a')

                ! Bucle para agregar filas a la tabla
                do i = 1, size(token_array)
                    write(str_tipo, '(A)') trim(token_array(i)%tipo)
                    write(str_columna, '(I0)') token_array(i)%columna
                    write(str_fila, '(I0)') token_array(i)%fila
                    write(char_token, '(A)') trim(token_array(i)%lexema)

                    ! Escribir cada fila directamente al archivo
                    write(file_unit, '(A)') '<tr><td>' // char_token // '</td><td>' // trim(str_tipo) // &
                        '</td><td>' // trim(str_columna) // '</td><td>' // trim(str_fila) // '</td></tr>' // new_line('a')
                end do

                ! Cerrar la tabla y el HTML
                write(file_unit, '(A)') '</table></body></html>'
                close(file_unit)
            end if
        end if
    end subroutine generar_html_tokens

    subroutine parser()

        integer :: i

        ! Verifica si la memoria ha sido asignada para el arreglo
        if (.NOT. ALLOCATED(token_array)) then
            print *, "No hay tokens"
        else

            DO i = 1, size(token_array)

                if (token_array(i)%tipo == 'tk_etiqueta') then
                    if (token_array(i+1)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_pyc' ) then
                        call agregar_etiqueta(token_array(i+1)%lexema)
                    else
                        ! call agregar_error(aux_tkn, 'Error lexico', fila, columna)
                        !CALL agregar_error("Lexico", fila, columna, char, "error de token" )
                        call agregar_error("Sintactico", token_array(i+1)%fila, token_array(i+1)%columna, token_array(i+1)%lexema, 'tk_id' )
                    end if
                end if

                if (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_punto' ) then

                    if(token_array(i+2)%tipo == 'tk_setAncho') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error("Sintactico", token_array(i+3)%fila,token_array(i+3)%columna, token_array(i+3)%lexema, 'tk_par_izq' )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error("Sintactico", token_array(i+4)%fila,token_array(i+4)%columna, token_array(i+4)%lexema, 'tk_num' )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error("Sintactico", token_array(i+5)%fila,token_array(i+5)%columna, token_array(i+5)%lexema, 'tk_par_der' )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error("Sintactico", token_array(i+6)%fila,token_array(i+6)%columna, token_array(i+6)%lexema, 'tk_pyc' )
                        
                        else
                            call etiqueta_set_ancho(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                        end if


                    end if

                    if(token_array(i+2)%tipo == 'tk_setAlto') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error("Sintactico", token_array(i+3)%fila,token_array(i+3)%columna, token_array(i+3)%lexema, 'tk_par_izq' )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                           
                            call agregar_error("sintactico", token_array(i+4)%fila,token_array(i+4)%columna, token_array(i+4)%lexema, 'tk_num')
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error("sintactico", token_array(i+5)%fila,token_array(i+5)%columna, token_array(i+5)%lexema, 'tk_par_der' )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error("sintactico", token_array(i+6)%fila,token_array(i+6)%columna, token_array(i+6)%lexema, 'tk_pyc')
                        
                        else
                            call etiqueta_set_alto(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                        end if

                    end if


                    if(token_array(i+2)%tipo == 'tk_setTexto') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error("sintactico", token_array(i+3)%fila, token_array(i+3)%columna,token_array(i+3)%lexema, 'tk_par_izq' )

                        elseif (token_array(i+4)%tipo .ne. 'tk_literal') then
                            call agregar_error("sintactico", token_array(i+4)%fila, token_array(i+4)%columna,token_array(i+4)%lexema, 'tk_literal' )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error("sintactico", token_array(i+5)%fila, token_array(i+5)%columna,token_array(i+5)%lexema, 'tk_par_der' )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error("sintactico", token_array(i+6)%fila, token_array(i+6)%columna,token_array(i+6)%lexema, 'tk_pyc')
                        
                        else
                            call etiqueta_set_texto(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_setColorLetra') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error("Sintactico", token_array(i+3)%fila,token_array(i+3)%columna, token_array(i+3)%lexema, 'tk_par_izq' )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error("Sintactico", token_array(i+4)%fila, token_array(i+4)%columna, token_array(i+4)%lexema, 'tk_num')
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_coma') then
                            call agregar_error("Sintactico", token_array(i+5)%fila, token_array(i+5)%columna, token_array(i+5)%lexema, 'tk_coma')

                        elseif (token_array(i+6)%tipo .ne. 'tk_num') then
                            call agregar_error("sintactico", token_array(i+6)%fila, token_array(i+6)%columna, token_array(i+6)%lexema, 'tk_num')

                        elseif (token_array(i+7)%tipo .ne. 'tk_coma') then
                            call agregar_error("sintactico", token_array(i+7)%fila, token_array(i+7)%columna, token_array(i+7)%lexema, 'tk_coma')

                        elseif (token_array(i+8)%tipo .ne. 'tk_num') then
                            call agregar_error("Sintactico", token_array(i+8)%fila, token_array(i+8)%columna, token_array(i+8)%lexema, 'tk_num')

                        elseif (token_array(i+9)%tipo .ne. 'tk_par_der') then
                            call agregar_error("Sintactico", token_array(i+9)%fila, token_array(i+9)%columna, token_array(i+9)%lexema, 'tk_par_der')

                        elseif (token_array(i+10)%tipo .ne. 'tk_pyc') then
                            call agregar_error("Sintactico", token_array(i+10)%fila, token_array(i+10)%columna, token_array(i+10)%lexema, 'tk_pyc')
                        
                        else
                            call etiqueta_set_color_texto(token_array(i)%lexema,token_array(i+4)%lexema, token_array(i+6)%lexema, token_array(i+8)%lexema )
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_setPosicion') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error("sintactico", token_array(i+3)%fila, token_array(i+3)%columna, token_array(i+3)%lexema, 'tk_par_izq')

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error("Sintactico", token_array(i+4)%fila, token_array(i+4)%columna, token_array(i+4)%lexema, 'tk_num')
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_coma') then
                            call agregar_error("sintactico", token_array(i+5)%fila, token_array(i+5)%columna, token_array(i+5)%lexema, 'tk_coma')

                        elseif (token_array(i+6)%tipo .ne. 'tk_num') then
                            call agregar_error("Sintactico", token_array(i+6)%fila, token_array(i+6)%columna, token_array(i+6)%lexema, 'tk_num')

                        elseif (token_array(i+7)%tipo .ne. 'tk_par_der') then
                            call agregar_error("sintactico", token_array(i+7)%fila, token_array(i+7)%columna, token_array(i+7)%lexema, 'tk_par_der')

                        elseif (token_array(i+8)%tipo .ne. 'tk_pyc') then
                            call agregar_error("sintactico", token_array(i+8)%fila, token_array(i+8)%columna, token_array(i+8)%lexema, 'tk_pyc')
                        
                        else
                            call etiqueta_set_posicion(token_array(i)%lexema,token_array(i+4)%lexema,token_array(i+6)%lexema)
                            
                        end if

                    end if







                end if



            
            END DO
        end if



    end subroutine parser
    

END MODULE token


! gramatica en notacion BNF

! <inicio> ::= tk_etiqueta tk_id tk_pyc
!            |  tk_contenedor tk_id tk_pyc
!            |   tk_boton tk_id tk_pyc
!            | tk_id tk_punto <propiedad> tk_par_izq <expresion> tk_par_der tk_pyc

! <propiedad> ::= tk_setAncho
!              | tk_setAlto
!....

! <expresion> ::= <numeros>
!               | tk_literal
!               | tk_id

! <numeros> ::= tk_numero
!              | tk_numero tk_coma tk_numero tk_coma tk_numero