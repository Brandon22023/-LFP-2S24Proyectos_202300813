MODULE token
    use error
    use etiqueta
    use contenedor
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
            
                ! print *, 'lexema: ', trim(token_array(i)%lexema)
                ! print *, 'tipo: ', trim(token_array(i)%tipo)
                ! print *, 'fila: ', trim(str_fila)
                ! print *, 'columna: ', trim(str_columna)
                ! print *, '---------------------------------'
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
              
            if (token_array(1)%tipo .ne. "tk_menor") then
                call agregar_error(token_array(1)%lexema, 'tk_menor', token_array(1)%fila, token_array(1)%columna)
            ! elseif (token_array(2)%tipo .ne. "tk_exp") then
            !     call agregar_error(token_array(2)%lexema, 'tk_exp', token_array(2)%fila, token_array(2)%columna)
            ! elseif (token_array(3)%tipo .ne. "tk_guion") then
            !     call agregar_error(token_array(3)%lexema, 'tk_guion', token_array(3)%fila, token_array(3)%columna)
            ! elseif (token_array(4)%tipo .ne. "tk_guion") then
            !     call agregar_error(token_array(4)%lexema, 'tk_guion', token_array(4)%fila, token_array(4)%columna)
            ! elseif (token_array(5)%tipo .ne. "tk_id") then
            !     call agregar_error(token_array(5)%lexema, 'tk_id', token_array(5)%fila, token_array(5)%columna)
            end if
             
            DO i = 1, size(token_array)
                

                if (token_array(i)%tipo== "tk_menor") then
                    if (token_array(i+1)%tipo .ne. "tk_exp") then
                        call agregar_error(token_array(i+1)%lexema, 'tk_exp', token_array(i+1)%fila, token_array(i+1)%columna)
                    elseif (token_array(i+2)%tipo .ne. "tk_guion") then 
                        call agregar_error(token_array(i+2)%lexema, 'tk_guion', token_array(i+2)%fila, token_array(i+2)%columna)
                    elseif (token_array(i+3)%tipo .ne. "tk_guion") then
                        call agregar_error(token_array(i+3)%lexema, 'tk_guion', token_array(i+3)%fila, token_array(i+3)%columna)
                    elseif (token_array(i+4)%tipo .ne. "tk_id") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_id', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if 
                elseif (token_array(i)%tipo == "tk_pyc" .and. token_array(i+1)%tipo == "tk_id" .and. token_array(i+2)%tipo == "tk_guion") then
                    if (token_array(i+3)%tipo .ne. "tk_guion") then
                        call agregar_error(token_array(i+3)%lexema, 'tk_guion', token_array(i+3)%fila, token_array(i+3)%columna)
                    elseif (token_array(i+4)%tipo .ne. "tk_mayor") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_mayor', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if
                elseif (token_array(i)%tipo == "tk_pyc" .and. token_array(i+1)%tipo .ne. "tk_id" .and. token_array(i+2)%tipo == "tk_guion") then
                    call agregar_error(token_array(i+1)%lexema, 'tk_id', token_array(i+1)%fila, token_array(i+1)%columna)
                    if (token_array(i+3)%tipo .ne. "tk_guion") then
                        call agregar_error(token_array(i+3)%lexema, 'tk_guion', token_array(i+3)%fila, token_array(i+3)%columna)
                    elseif (token_array(i+4)%tipo .ne. "tk_mayor") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_mayor', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if
                elseif (token_array(i)%tipo .ne. "tk_pyc" .and. token_array(i+1)%tipo == "tk_id" .and. token_array(i+2)%tipo == "tk_guion") then
                    call agregar_error(token_array(i)%lexema, 'tk_pyc', token_array(i)%fila, token_array(i)%columna)
                    if (token_array(i+3)%tipo .ne. "tk_guion") then
                        call agregar_error(token_array(i+3)%lexema, 'tk_guion', token_array(i+3)%fila, token_array(i+3)%columna)
                    elseif (token_array(i+4)%tipo .ne. "tk_mayor") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_mayor', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if
                elseif (token_array(i)%tipo == "tk_pyc" .and. token_array(i+1)%tipo == "tk_id" .and. token_array(i+2)%tipo .ne. "tk_guion" .and. token_array(i+3)%tipo == "tk_guion") then
                    call agregar_error(token_array(i+2)%lexema, 'tk_guion', token_array(i+2)%fila, token_array(i+2)%columna)
                    if (token_array(i+4)%tipo .ne. "tk_mayor") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_mayor', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if
                elseif (token_array(i+1)%tipo == "tk_id" .and. token_array(i+2)%tipo == "tk_guion" .and. token_array(i+3)%tipo == "tk_guion")then
                    if (token_array(i+4)%tipo .ne. "tk_mayor") then
                        call agregar_error(token_array(i+4)%lexema, 'tk_mayor', token_array(i+4)%fila, token_array(i+4)%columna)
                    end if
                end if

                if (token_array(i)%tipo == 'tk_etiqueta') then
                    if (token_array(i+1)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_pyc' ) then
                        call agregar_etiqueta(token_array(i+1)%lexema)
                    else
                        call agregar_error(token_array(i+1)%lexema, 'tk_id', token_array(i+1)%fila, token_array(i+1)%columna )
                    end if
                end if

                if (token_array(i)%tipo == 'tk_contenedor') then
                    if (token_array(i+1)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_pyc' ) then
                        call agregar_contenedor(token_array(i+1)%lexema)
                    else
                        call agregar_error(token_array(i+1)%lexema, 'tk_id', token_array(i+1)%fila, token_array(i+1)%columna )
                    end if
                end if

                ! Validar si después de un 'tk_id' no viene un 'tk_punto'
                if (token_array(i)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_setAncho' .and. token_array(i+3)%tipo == 'tk_par_izq') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        ! Si después del 'tk_id' no hay un 'tk_punto', se marca un error
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_setAlto' .and. token_array(i+3)%tipo == 'tk_par_izq') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_setTexto' .and. token_array(i+3)%tipo == 'tk_par_izq') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_setColorLetra' .and. token_array(i+3)%tipo == 'tk_par_izq') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+2)%tipo == 'tk_setPosicion' .and. token_array(i+3)%tipo == 'tk_par_izq') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                end if

                ! Validar si después de un 'tk_id' no viene un 'tk_punto'
                if (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_setAncho' .and. token_array(i+2)%tipo == 'tk_par_izq' .or. token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_par_izq' .and. token_array(i+2)%tipo == 'tk_num' ) then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        ! Si después del 'tk_id' no hay un 'tk_punto', se marca un error
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_setAlto' .and. token_array(i+2)%tipo == 'tk_par_izq' .or. token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_par_izq' .and. token_array(i+2)%tipo == 'tk_num') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_setTexto' .and. token_array(i+2)%tipo == 'tk_par_izq' .or. token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_par_izq' .and. token_array(i+2)%tipo == 'tk_num') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_setColorLetra' .and. token_array(i+2)%tipo == 'tk_par_izq' .or. token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_par_izq' .and. token_array(i+2)%tipo == 'tk_num') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                elseif (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_setPosicion' .and. token_array(i+2)%tipo == 'tk_par_izq'.or. token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_par_izq' .and. token_array(i+2)%tipo == 'tk_num') then
                    if (token_array(i+1)%tipo .ne. 'tk_punto') then
                        call agregar_error(token_array(i+1)%lexema, 'tk_punto', token_array(i+1)%fila, token_array(i+1)%columna)
                    end if
                end if

                if (token_array(i)%tipo == 'tk_id' .and. token_array(i+1)%tipo == 'tk_punto' ) then

                    if(token_array(i+2)%tipo == 'tk_setAncho') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_par_der', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_pyc', token_array(i+6)%fila,token_array(i+6)%columna )
                        
                        else
                            call etiqueta_set_ancho(token_array(i)%lexema,token_array(i+4)%lexema)
                            call contenedor_set_ancho(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                        end if
                    end if

                    if(token_array(i+2)%tipo == 'tk_setAlto') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_par_der', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_pyc', token_array(i+6)%fila,token_array(i+6)%columna )
                        
                        else
                            call etiqueta_set_alto(token_array(i)%lexema,token_array(i+4)%lexema)
                            call contenedor_set_alto(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                        end if

                    end if


                    if(token_array(i+2)%tipo == 'tk_setTexto') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_literal') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_literal', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_par_der', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_pyc', token_array(i+6)%fila,token_array(i+6)%columna )
                        
                        else
                            call etiqueta_set_texto(token_array(i)%lexema,token_array(i+4)%lexema)
                            
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_setColorLetra') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_coma') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_coma', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_num', token_array(i+6)%fila,token_array(i+6)%columna )

                        elseif (token_array(i+7)%tipo .ne. 'tk_coma') then
                            call agregar_error(token_array(i+7)%lexema, 'tk_coma', token_array(i+7)%fila,token_array(i+7)%columna )

                        elseif (token_array(i+8)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+8)%lexema, 'tk_num', token_array(i+8)%fila,token_array(i+8)%columna )

                        elseif (token_array(i+9)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+9)%lexema, 'tk_par_der', token_array(i+9)%fila,token_array(i+9)%columna )

                        elseif (token_array(i+10)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+10)%lexema, 'tk_pyc', token_array(i+10)%fila,token_array(i+10)%columna )
                        
                        else
                            call etiqueta_set_color_texto(token_array(i)%lexema,token_array(i+4)%lexema, token_array(i+6)%lexema, token_array(i+8)%lexema)
                            
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_setPosicion') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_coma') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_coma', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_num', token_array(i+6)%fila,token_array(i+6)%columna )

                        elseif (token_array(i+7)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+7)%lexema, 'tk_par_der', token_array(i+7)%fila,token_array(i+7)%columna )

                        elseif (token_array(i+8)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+8)%lexema, 'tk_pyc', token_array(i+8)%fila,token_array(i+8)%columna )
                        
                        else
                            call etiqueta_set_posicion(token_array(i)%lexema,token_array(i+4)%lexema,token_array(i+6)%lexema)
                            call contenedor_set_posicion(token_array(i)%lexema,token_array(i+4)%lexema,token_array(i+6)%lexema)
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_setColorFondo') then
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )

                        elseif (token_array(i+4)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        
                        elseif (token_array(i+5)%tipo .ne. 'tk_coma') then
                            call agregar_error(token_array(i+5)%lexema, 'tk_coma', token_array(i+5)%fila,token_array(i+5)%columna )

                        elseif (token_array(i+6)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_num', token_array(i+6)%fila,token_array(i+6)%columna )

                        elseif (token_array(i+7)%tipo .ne. 'tk_coma') then
                            call agregar_error(token_array(i+7)%lexema, 'tk_coma', token_array(i+7)%fila,token_array(i+7)%columna )

                        elseif (token_array(i+8)%tipo .ne. 'tk_num') then
                            call agregar_error(token_array(i+8)%lexema, 'tk_num', token_array(i+8)%fila,token_array(i+8)%columna )

                        elseif (token_array(i+9)%tipo .ne. 'tk_par_der') then
                            call agregar_error(token_array(i+9)%lexema, 'tk_par_der', token_array(i+9)%fila,token_array(i+9)%columna )

                        elseif (token_array(i+10)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+10)%lexema, 'tk_pyc', token_array(i+10)%fila,token_array(i+10)%columna )
                        
                        else
                            call contenedor_set_color_fondo(token_array(i)%lexema,token_array(i+4)%lexema, token_array(i+6)%lexema, token_array(i+8)%lexema )
                            
                        end if

                    end if

                    if(token_array(i+2)%tipo == 'tk_add') then
                        !print *, token_array(i+2)%tipo
                        if (token_array(i+3)%tipo .ne. 'tk_par_izq') then
                            !print *, token_array(i+3)%tipo
                            call agregar_error(token_array(i+3)%lexema, 'tk_par_izq', token_array(i+3)%fila,token_array(i+3)%columna )
                        elseif (token_array(i+4)%tipo .ne. 'tk_id') then

                            !print *, token_array(i+4)%tipo
                            call agregar_error(token_array(i+4)%lexema, 'tk_num', token_array(i+4)%fila,token_array(i+4)%columna )
                        elseif (token_array(i+5)%tipo .ne. 'tk_par_der') then
                            print *, token_array(i+5)%tipo
                            call agregar_error(token_array(i+5)%lexema, 'tk_par_der', token_array(i+5)%fila,token_array(i+5)%columna )
                        elseif (token_array(i+6)%tipo .ne. 'tk_pyc') then
                            call agregar_error(token_array(i+6)%lexema, 'tk_pyc', token_array(i+6)%fila,token_array(i+6)%columna )
                        
                        else
                            call contenedor_set_add(token_array(i)%lexema,token_array(i+4)%lexema)
                            
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