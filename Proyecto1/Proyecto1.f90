program analizador_lexico
    implicit none
    integer :: i, len, linea, columna, estado, puntero, numErrores,file_unit,ios
    integer :: espacio_texto, longitud
    character(len=10000) :: contenido, cadena, buffer
    character(len=1) :: char 
    character(len=100) :: tkn
    character(len=1), dimension(26) :: A 
    character(len=1), dimension(26) :: M
    character(len=1), dimension(3) :: S 
    character(len=1), dimension(1) :: C
    character(len=1), dimension(3) :: R
    character(len=1), dimension(1) :: P
    character(len=1), dimension(11) :: N
    character(len=1) :: char_error
    integer, dimension(100,4) :: errores 
    character(len=10000) :: entrada
    integer, parameter :: max_tokens = 1000
    character(len=100), dimension(max_tokens) :: token_list
    integer :: num_tokens
    A = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    M = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    S = ['{','}',';']
    C = ['"']
    R = [':','\','.']
    P = [':']
    N = ['0','1','2','3','4','5','6','7','8','9', '%']
    estado = 0
    num_tokens = 0
    puntero = 1
    columna = 1
    linea = 1
    numErrores = 0
    contenido = ""
    tkn = " "
    ! Lee el contenido desde la entrada estándar
    do
        read(*, '(A)', IOSTAT=ios) buffer
        if (ios /= 0) exit  ! Sale del bucle si ya no hay más datos
        contenido = trim(contenido) // trim(buffer) // new_line("a")
    end do
    !print *, 'Contenido del archivo recibido desde Python:'
    !print *, trim(contenido)
    len = len_trim(contenido)
    do while(puntero <= len)
        char = contenido(puntero:puntero)
        !print *, char, " linea", linea, "columna", columna
        !print *, 'Código ASCII:', ichar(char), ' Línea:', linea, ' Columna:', columna
        !print *,  char, ' Linea:', linea, ' Columna:', columna
        !print *, char, ' Línea:', linea, ' Columna:', columna
        !print *, char, " estado de contenido", estado
        !ichar es para el codigo ascii
        if (ichar(char) == 10) then
            ! Salto de línea (LF)
            columna = 1
            linea = linea + 1
            puntero = puntero + 1

        elseif(ichar(char) == 9) then
        !tabulacion
            columna = columna + 4
            puntero = puntero + 1
        elseif(ichar(char) == 32) then
           ! espacio en blacno
           columna = columna + 1
           puntero = puntero + 1
        
        else 
         ! Si no es un salto de línea, tabulación o espacio, entra en el análisis de estados
            select case (estado)
                case (0)
                ! VERIFICAR QUE VENGA EN MI LENGUAJE UNA MAYUSCULA EN LA PRIMERA POSICIÓN
                !any sirve para verificar si hay existe dentro de mi lista
                    if (any(char == M)) then 
                        estado = 1
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn =trim(tkn) // char !adjustl para evitar problemas de espacios en blanco que puedan interferir.
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif(any(char == S)) then 
                        estado = 1
                        columna = columna + 1
                    else
                        ! Si el carácter no es una letra minuscula, se cuenta como error
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    
                    end if
                    puntero = puntero + 1 ! Avanza un carácter
                case (1)
                ! Continuamos leyendo tokens (letras minúsculas)
                    if (any(char == M)) then
                        estado = 1
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif(any(char == A)) then
                        estado = 1
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif(any(char == C)) then
                        estado = 4
                        columna = columna + 1

                    elseif (any(char == P)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 2
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                    elseif (any(char == S)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 3
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
                case (2)
                ! Estado para manejar símbolos
                    if (any(char == S)) then
                        columna = columna + 1
                        estado = 3
                        ! agregar el char
                    
                    elseif (any(char == M)) then
                        estado = 2
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif (any(char == N)) then
                        estado = 5
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif(any(char == C)) then
                        estado = 4
                        columna = columna + 1
                    
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
                    
                case (3)
                     ! Continuamos leyendo dentro de un bloque (por ejemplo, después de '{')
                    
                    if (any(char == M)) then 
                        estado = 3
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    elseif (any(char == S)) then
                    ! Encontramos otro símbolo, cambiamos al estado 4
                        columna = columna + 1
                        estado = 1
                        !agregar a tabla de tokens el tkn y el char
                        num_tokens = num_tokens + 1
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                    elseif (any(char == P)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 2
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                    end if
                    puntero = puntero + 1
                case (4)
                    ! Continuamos leyendo tokens (letras minúsculas)
                    if (any(char == C)) then
                        estado = 4
                        columna = columna + 1

                    elseif (any(char == M) .or. any(char == A) .or. any(char == R) .or. any(char == N) .or. any(char == P)) then
                        estado = 4
                        columna = columna + 1
                        tkn = trim(tkn) //char
                    elseif (any(char == S)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 0
                        !agregar a tabla de tokens el tkn y el char
                        num_tokens = num_tokens + 1
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        puntero = puntero + 1
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
                case(5)
                    ! Continuamos leyendo tokens (numeros)
                    if (any(char == N)) then
                        estado = 5
                        columna = columna + 1
                        !print *, 'Carácter añadido a tkn:', char
                        tkn = trim(tkn) // char
                        !print *, 'tkn hasta ahora:', trim(tkn)
                    
                    elseif (any(char == S)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 3
                        !agregar a tabla de tokens el tkn y el char
                        num_tokens = num_tokens + 1
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0) then
                            num_tokens = num_tokens + 1
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            print *, 'Token reseteado'
                        else
                            print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        puntero = puntero + 1
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
            end select
        end if
        
    end do
     
    ! Imprimir tabla de tokens
    print *, "Tokens extraidos:"
    do i = 1, num_tokens
        print *, i, trim(token_list(i))
    end do
    ! Mostrar errores si hay alguno.
    if (numErrores > 0 ) then
   
       do i=1, numErrores 
            char_error = achar(errores(i,1))
            print *, "Error en caracter: ", char_error, " Linea: ", errores(i,4), "Columna: ", errores(i,3)
        end do
    else 
        print *, trim("No hubieron Errores")
    end if
end program analizador_lexico