module datos_globales
    implicit none
    integer :: num_continentes
    integer :: num_paises
    integer :: num_saturacion
    integer :: contador_continente
    integer :: contador_pais
    integer :: contador_poblacion
    integer :: contador_bandera
    integer :: contador_promedio_continente
    integer :: contador_promedio_cantidad
    integer :: contador_paises_continente
    character(len=20) :: continentes(20) ! Arreglo de 20 continentes con longitud de 20 caracteres
    character(len=20) :: paises(100) ! Arreglo de 100 paises con longitud de 20 caracteres
    character(len=20) :: saturacion(100)
    character(len=20) :: Seleccionar_pais(100)
    character(len=50) :: poblacion(100)
    character(len=1000) :: bandera(100)
    character(len=1000) :: paises_continente(100)
    character(len=20) :: promedio_continente(100)
    real(kind=4) :: promedio_cantidad(100)
end module datos_globales
program analizador_lexico
    use datos_globales
    implicit none
    integer :: i, len,linea,columna, estado, puntero, numErrores,file_unit,ios,numtkn
    integer :: espacio_texto, longitud
    character(len=10000) :: contenido, cadena, buffer
    integer :: dist, j
    character(len=1) :: char 
    character(len=100) :: tkn
    character(len=1) :: tknpunto
    character(len=1) :: tknllaves
    character(len=1) :: tknpuntocoma
    character(len=1), dimension(26) :: A 
    character(len=1), dimension(26) :: M
    character(len=1), dimension(3) :: S 
    character(len=1), dimension(1) :: C
    character(len=1), dimension(17) :: R
    character(len=1), dimension(1) :: P
    character(len=1), dimension(11) :: N
    character(len=12), dimension(7) :: diccionario
    character(len=1) :: char_error, char_token
    character(len=10000) :: entrada
    integer, parameter :: max_tokens = 1000
    character(len=100), dimension(max_tokens) :: token_list
    logical :: solo_numeros, tiene_porcentaje
    integer :: t, ascii_val
    
    integer :: num_tokens

    
    
    type :: ErrorInfo
        character(len=10) :: caracter  ! caracter
        character(len=100) :: descripcion  ! Descripción del error
        integer :: columna      ! Columna donde ocurrió el error
        integer :: linea        ! Línea donde ocurrió el error
    end type ErrorInfo
    type :: tokenInfo
        character(len=100) :: caracter  ! caracter
        character(len=100) :: descripcion  ! Descripción del error
        integer :: columna      ! Columna donde ocurrió el error
        integer :: linea        ! Línea donde ocurrió el error
    end type tokenInfo
    type(ErrorInfo), dimension(1000) :: errores
    type(tokenInfo), dimension(10000) :: tokens

    A = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    M = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    S = ['{','}',';']
    C = ['"']
    R = [':','\','.','!','_','-',',','#','$','&','/','(',')','?','~','@','^']
    P = [':']
    N = ['0','1','2','3','4','5','6','7','8','9', '%']
    diccionario = ['grafica     ', 'nombre      ', 'continente  ', 'poblacion   ', 'saturacion  ', 'bandera     ', 'pais        ']
    estado = 0
    num_tokens = 0
    numtkn= 0
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
        !print *,"TKN:", trim(tkn), "  ", estado
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

                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                    else
                        ! Si el carácter no es una letra minuscula, se cuenta como error
                        numErrores = numErrores + 1
                        errores(numErrores) = ErrorInfo(char, "Error no pertenece al lenguaje M", columna, linea)
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
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            if (tkn == "grafica" .or. tkn == "continente" .or. tkn == "pais" .or. &
                               tkn == "nombre" .or. tkn == "bandera" .or. tkn == "poblacion" .or. &
                               tkn == "saturacion") then

                                numtkn = numtkn + 1
                                tokens(numtkn) = tokenInfo(tkn, "Palabra reservada", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if

                            else
                                ! Error de token
                                numErrores = numErrores + 1
                                errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        tknpunto = ":"
                        numtkn = numtkn + 1
                        tokens(numtkn) = tokenInfo(tknpunto, "dos puntos", columna, linea)
                    elseif (any(char == S)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 3
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            if (tkn == "grafica" .or. tkn == "continente" .or. tkn == "pais" .or. &
                               tkn == "nombre" .or. tkn == "bandera" .or. tkn == "poblacion" .or. &
                               tkn == "saturacion") then

                                numtkn = numtkn + 1
                                tokens(numtkn) = tokenInfo(tkn, "Palabra reservada", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if

                            else
                                ! Error de token
                                numErrores = numErrores + 1
                                errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if

                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                        
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores) = ErrorInfo(char, "caracter no pertecene", columna, linea)
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
                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                    
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
                        errores(numErrores) = ErrorInfo(char, "caracter no pertecene", columna, linea)
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
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            if (tkn == "grafica" .or. tkn == "continente" .or. tkn == "pais" .or. &
                               tkn == "nombre" .or. tkn == "bandera" .or. tkn == "poblacion" .or. &
                               tkn == "saturacion") then
                                numtkn = numtkn + 1
                                tokens(numtkn) = tokenInfo(tkn, "Palabra reservada", columna, linea)
                               
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if

                            else
                                ! Error de token
                                numErrores = numErrores + 1
                                errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                    elseif (any(char == P)) then
                     ! Encontramos un símbolo, cambiamos al estado 2
                        columna = columna + 1
                        estado = 2
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            if (tkn == "grafica" .or. tkn == "continente" .or. tkn == "pais" .or. &
                               tkn == "nombre" .or. tkn == "bandera" .or. tkn == "poblacion" .or. &
                               tkn == "saturacion") then

                                numtkn = numtkn + 1
                                tokens(numtkn) = tokenInfo(tkn, "Palabra reservada", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if

                            else
                                ! Error de token
                                numErrores = numErrores + 1
                                errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                if (num_tokens <= max_tokens) then
                                    !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                    token_list(num_tokens) = trim(tkn)
                                    !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                else
                                    print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                end if
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        
                        tknpunto = ":"
                        numtkn = numtkn + 1
                        tokens(numtkn) = tokenInfo(tknpunto, "dos puntos", columna, linea)
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores) = ErrorInfo(char, "caracter no pertecene", columna, linea)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
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
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo('"'//trim(tkn)//'"', "Cadena", columna, linea)
                            if (num_tokens <= max_tokens) then
                                !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                token_list(num_tokens) = trim(tkn)
                                !print *, 'Token añadido a la lista:', token_list(num_tokens)
                            else
                                print *, "Error: Se ha alcanzado el límite máximo de tokens."
                            end if
                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores) = ErrorInfo(char, "caracter no pertecene", columna, linea)
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
                        ! Agregar el token actual si no está vacío
                        if (len_trim(tkn) > 0 .and. trim(tkn) /= " ") then
                            num_tokens = num_tokens + 1
                            
                            ! Inicializamos la variable para verificar si es solo números
                            solo_numeros = .true.

                            ! Inicializamos la variable para verificar si el token termina con '%'
                            tiene_porcentaje = .false.

                            ! Verificar si el token termina con '%'
                            if (tkn(len_trim(tkn):len_trim(tkn)) == '%') then
                                tiene_porcentaje = .true.
                                ! Quitar el '%' temporalmente para verificar si el resto son números
                                tkn = tkn(1:len_trim(tkn) - 1)
                            end if

                            ! Recorrer cada carácter de tkn(ya sin contener el %)
                            do t = 1, len_trim(tkn)
                                ! Obtener el valor ASCII del carácter actual
                                ascii_val = ichar(tkn(t:t))
                                
                                ! Verificar si el carácter no es un número (ASCII 48-57 corresponden a '0'-'9')
                                if (ascii_val < 48 .or. ascii_val > 57) then
                                    solo_numeros = .false.
                                    exit  ! Salir del bucle, ya que encontramos un carácter no numérico
                                end if
                            end do
                            if (solo_numeros) then
                                if (tiene_porcentaje) then
                                    numtkn = numtkn + 1
                                    tokens(numtkn) = tokenInfo(tkn, "numeros", columna, linea)
                                    tkn= trim(tkn)//'%'
                                    numtkn = numtkn + 1
                                    tokens(numtkn) = tokenInfo("%", "porcentaje", columna, linea)
                                    if (num_tokens <= max_tokens) then
                                        !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                        token_list(num_tokens) = trim(tkn)
                                        !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                    else
                                        print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                    end if


                                else
                                    numtkn = numtkn + 1
                                    tokens(numtkn) = tokenInfo(tkn, "numeros", columna, linea)
                                    if (num_tokens <= max_tokens) then
                                        !print *, 'Token acumulado antes de agregar:', trim(tkn), 'Longitud:', len_trim(tkn)
                                        token_list(num_tokens) = trim(tkn)
                                        !print *, 'Token añadido a la lista:', token_list(num_tokens)
                                    else
                                        print *, "Error: Se ha alcanzado el límite máximo de tokens."
                                    end if
                                end if
                            else
                                if (tiene_porcentaje) then 
                                    tkn= trim(tkn)//'%'
                                    numErrores = numErrores + 1
                                    errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                else
                                    numErrores = numErrores + 1
                                    errores(numErrores) = ErrorInfo(tkn, "Error de token", columna, linea)
                                end if
                            end if

                            tkn = " "  ! Reiniciar token después de agregar
                            !print *, 'Token reseteado'
                        else
                            !print *, 'No se agregó el token ya que estaba vacío.'
                        end if
                        
                        if (char == "{") then
                            tknllaves = "{"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves abiertas", columna, linea)
                        elseif (char == "}") then
                            tknllaves = "}"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknllaves, "llaves cerradas", columna, linea)
                        elseif (char == ";") then
                            tknpuntocoma = ";"
                            numtkn = numtkn + 1
                            tokens(numtkn) = tokenInfo(tknpuntocoma, "punto y coma", columna, linea)
                        else
                        end if
                    else
                    ! Error de token
                        numErrores = numErrores + 1
                        errores(numErrores) = ErrorInfo(char, "caracter no pertecene", columna, linea)
                        columna = columna + 1
                        estado = 5
                    
                    end if        
                    puntero = puntero + 1 ! Avanza un carácter
            end select
        end if
    end do
    ! Si hay errores, se crea el archivo HTML
    if (numErrores > 0) then
      call generar_html_errores(numErrores, errores)
    else
        !print *, "No hay errores en el código."
    end if

    if (numtkn > 0) then
      call generar_html_tokens(numtkn, tokens)
    else
        !print *, "No hay errores en el código, por lo que no es posible generar el html de tokens."
    end if

    call generar_dot()

    


   
   

     ! Imprimir tabla de tokens
    !print *, "Tokens extraidos:"
    do i = 1, num_tokens
        !print *, i, trim(token_list(i))
    end do

    
    
    contains

        subroutine generar_html_errores(numErrores, errores)
            integer, intent(in) :: numErrores
            type(ErrorInfo), intent(in) :: errores(:)
            character(len=100000) :: html_content
            character(len=100) :: str_descripcion, str_columna, str_linea,char_error

            integer :: file_unit, ios, i

                ! Si hay errores, se crea el archivo HTML
            if (numErrores > 0) then
            ! Abrir el archivo para escribir
                open(unit=file_unit, file="errores.html", status="replace", action="write", iostat=ios)
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
                    write(file_unit, '(A)') '</style></head><body><h2>Tabla de Errores</h2>' // new_line('a')
                    write(file_unit, '(A)') '<table><tr><th>Carácter</th><th>Descripcion' 
                    write(file_unit, '(A)') '</th><th>Columna</th><th>Línea</th></tr>' // new_line('a')

                        ! Bucle para formatear cada código ASCII y cada columna

                        ! Bucle para agregar filas a la tabla
                    do i = 1, numErrores
                        write(str_descripcion, '(A)') trim(errores(i)%descripcion)
                        write(str_columna, '(I0)') errores(i)%columna
                        write(str_linea, '(I0)')  errores(i)%linea
                        write(char_error, '(A)') trim(errores(i)%caracter)
                
                            ! Escribir cada fila directamente al archivo

                         write(file_unit, '(A)') '<tr><td>' // char_error // '</td><td>' // trim(str_descripcion) // & 
                        '</td><td>' // trim(str_columna) // '</td><td>'&
                        // trim(str_linea) // '</td></tr>' // new_line('a')
                    end do

                        ! Cerrar la tabla y el HTML
                    write(file_unit, '(A)') '</table></body></html>'
                    close(file_unit)
                end if
            else
                !print *, "No hay errores en el código."
            end if
        end subroutine generar_html_errores

        subroutine generar_html_tokens(numtkn, tokens)
            integer, intent(in) :: numtkn
            type(tokenInfo), intent(in) :: tokens(:)
            character(len=100000) :: html_content
            character(len=100) :: str_descripcion, str_columna, str_linea,char_token

            integer :: file_unit, ios, i

                ! Si hay errores, se crea el archivo HTML
            if (numtkn > 0) then
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
                    write(file_unit, '(A)') '</style></head><body><h2>Tabla de Tokens Aceptables</h2>' // new_line('a')
                    write(file_unit, '(A)') '<table><tr><th>Lexema</th><th>Tipo' 
                    write(file_unit, '(A)') '</th><th>Columna</th><th>Línea</th></tr>' // new_line('a')

                        ! Bucle para formatear cada código ASCII y cada columna

                        ! Bucle para agregar filas a la tabla
                    do i = 1, numtkn
                        write(str_descripcion, '(A)') trim(tokens(i)%descripcion)
                        write(str_columna, '(I0)') tokens(i)%columna
                        write(str_linea, '(I0)')  tokens(i)%linea
                        write(char_token, '(A)') trim(tokens(i)%caracter)
                
                            ! Escribir cada fila directamente al archivo

                         write(file_unit, '(A)') '<tr><td>' // char_token // '</td><td>' // trim(str_descripcion) // & 
                        '</td><td>' // trim(str_columna) // '</td><td>'&
                        // trim(str_linea) // '</td></tr>' // new_line('a')
                    end do

                        ! Cerrar la tabla y el HTML
                    write(file_unit, '(A)') '</table></body></html>'
                    close(file_unit)
                end if
            else
                !print *, "No hay errores en el código."
            end if
        end subroutine generar_html_tokens


        subroutine generar_dot()
            use datos_globales
            implicit none
            integer :: i,k,l, real_saturacion
            character(len=100) :: i_string, pMnombre, pais_menor_porc, poblacion_grafica, bandera_grafica
            character(len=100) :: j_string  ! Tamaño ajustable según sea necesario
            character(len=100) :: C_string  ! Tamaño ajustable según sea necesario
            character(len=100) :: p_string  ! Tamaño ajustable según sea necesario
            character(len=100) :: Contador_continente_string  ! Tamaño ajustable según sea necesario
            character(len=20) :: saturacion_sin_porcentaje
            integer :: suma_saturacion, promedio_saturacion, promedio_menor
            
            integer :: num_paises_continente,real_saturacion_menor
            integer :: posicion_menor, posicion_menor_paiscompleto
            
            ! Abrimos el archivo para escribir el código DOT
            open(unit=10, file='grafo.dot', status='replace')

            ! Escribimos el encabezado del archivo DOT
            write(10, '(A)') 'digraph Grafo {'
            write(10, '(A)') 'node [shape=box, style=filled];'
            
            ! Nodo raíz
            write(10, '(A)') 'n0 [label= "' // trim(token_list(4)) // '", shape=diamond];'
            
            num_continentes = 0
            do i = 1, num_tokens - 3
                if (trim(token_list(i)) == 'continente') then  ! Comparamos cadenas eliminando espacios en blanco
                    if (num_continentes < 10) then  ! Aseguramos que no sobrepase el tamaño del arreglo continentes
                        num_continentes = num_continentes + 1
                        continentes(num_continentes) = token_list(i + 3)
                        !print *, num_continentes, 'Continente extraido:', trim(continentes(num_continentes))
                    else
                        print *, "Se ha alcanzado el máximo número de continentes."
                        exit  ! Salimos del bucle si ya tenemos el máximo de continentes
                    end if
                end if
            end do

            do i = 1, num_continentes
                print *, i, trim(continentes(i))
            end do
            num_paises = 0
            contador_pais = 0
            contador_paises_continente= 0
            do i = 1, num_tokens
                if (trim(token_list(i)) == 'continente') then  ! Detectamos un continente
                    num_paises = num_paises + 1
                    paises(num_paises) = token_list(i)  ! Asumimos que token_list(i+2) es el nombre del continente
                    contador_paises_continente = contador_paises_continente + 1
                    paises_continente(contador_paises_continente) = token_list(i)
                    contador_paises_continente = contador_paises_continente + 1
                    paises_continente(contador_paises_continente) = token_list(i+3)
                    !print *, num_paises, ' Continente extraido:', trim(paises(num_paises))

                    ! Procesamos los países dentro de este continente
                    do j = i+3, num_tokens  ! Avanzamos para empezar a buscar países dentro del continente
                        if (trim(token_list(j)) == 'pais') then
                            ! Buscamos el nombre del país
                            do k = j+1, num_tokens
                                if (trim(token_list(k)) == 'nombre') then
                                    num_paises = num_paises + 1
                                    contador_pais = contador_pais + 1
                                    paises(num_paises) = token_list(k+2)  ! Asumimos que token_list(k+2) es el nombre del país
                                    Seleccionar_pais(contador_pais) = token_list(k+2)
                                    contador_paises_continente = contador_paises_continente + 1
                                    paises_continente(contador_paises_continente) = token_list(k+2)
                                    !print *, num_paises, ' Pais extraido:', trim(paises(num_paises))
                                    exit  ! Salimos del bucle interno al encontrar el nombre del país
                                end if
                            end do
                        elseif (trim(token_list(j)) == 'continente') then
                            exit  ! Si encontramos otro continente, salimos del bucle
                        end if
                    end do
                end if
            end do


            do i = 1, num_paises
                print *, i, trim(paises(i))
            end do

            print*, "son solo paises"
            do i = 1, contador_pais
               print*, i, trim(Seleccionar_pais(i))
            end do

            print*, "continente, nombre y pais"
            do i = 1, contador_paises_continente
               print*, i, trim(paises_continente(i))
            end do

            num_saturacion = 0
            contador_poblacion = 0
            contador_bandera = 0
            
            do i = 1, num_tokens
                if (trim(token_list(i)) == 'saturacion') then  ! Comparamos cadenas eliminando espacios en blanco
                    if (num_saturacion < 100) then  ! Aseguramos que no sobrepase el tamaño del arreglo continentes
                        num_saturacion = num_saturacion + 1
                        saturacion(num_saturacion) = token_list(i + 1)
                        !print *, num_saturacion, 'Saturacion extraida:', trim(saturacion(num_saturacion))
                    else
                        print *, "Se ha alcanzado el máximo número de saturaciones."
                        exit  ! Salimos del bucle si ya tenemos el máximo de continentes
                    end if
                elseif (trim(token_list(i)) == 'poblacion') then
                    if (contador_poblacion < 100) then
                        contador_poblacion = contador_poblacion + 1
                        poblacion(contador_poblacion) = token_list(i + 1)
                        !print *, contador_poblacion, 'contador extraida:', trim(poblacion(contador_poblacion))
                    else
                        print *, "Se ha alcanzado el máximo número de poblaciones."
                        exit  ! Salimos del bucle si ya tenemos el máximo de continentes
                    end if

                elseif (trim(token_list(i)) == 'bandera') then
                    if (contador_bandera < 100) then
                        contador_bandera = contador_bandera + 1
                        bandera(contador_bandera) = token_list(i + 2)
                        !print *, contador_bandera, 'bandera extraida:', trim(bandera(contador_bandera)
                    else
                        print *, "Se ha alcanzado el máximo número de banderas."
                        exit  ! Salimos del bucle si ya tenemos el máximo de banderas
                    end if

                end if
            end do
            print*, "son solo saturaciones"
            do i = 1, num_saturacion
                print *, i, trim(saturacion(i))
            end do
            print*, "son solo poblaciones"
            do i = 1, contador_poblacion
                print *, i, trim(poblacion(i))
            end do
            print*, "son solo banderas"
            do i = 1, contador_bandera
                print *, i, trim(bandera(i))
            end do
            



            ! Nodo continentes
            j = 0
            contador_continente = 0
            contador_promedio_cantidad = 0
            contador_promedio_continente = 0
            posicion_menor = 0
            posicion_menor_paiscompleto = 1
            do i = 1, num_paises
                if (trim(paises(i)) == 'continente') then
                    ! Procesamos el continente
                    contador_continente = contador_continente + 1
                    write(i_string, '(I0)') contador_continente
                    
                    ! Inicializamos suma de saturación y el contador de países del continente actual
                    suma_saturacion = 0.0
                    num_paises_continente = 0
                    
                    ! Sumamos la saturación de los países que pertenecen a este continente
                    do k = i + 1, num_paises
                        if (trim(paises(k)) == 'continente') exit  ! Salimos al encontrar otro continente
                        if (trim(paises(k)) /= 'continente') then
                            ! Convertimos el valor de saturación a real y sumamos
                            j = j + 1  ! No reiniciamos 'j', sigue incrementando globalmente
                            real_saturacion = 0  ! Inicializamos a un valor por defecto
                            saturacion_sin_porcentaje = trim(adjustl(saturacion(j)))
                            saturacion_sin_porcentaje = saturacion_sin_porcentaje(1:len_trim(saturacion_sin_porcentaje)-1)  ! Eliminar el último carácter (%)
                            read(saturacion_sin_porcentaje, *) real_saturacion  ! Convertir a número real
                            
                            suma_saturacion = suma_saturacion + real_saturacion
                            num_paises_continente = num_paises_continente + 1
                        end if
                    end do
                    
                    ! Calculamos el promedio de saturación
                    if (num_paises_continente > 0) then
                        promedio_saturacion = suma_saturacion / num_paises_continente
                    else
                        promedio_saturacion = 0.0  ! Si no hay países, el promedio es 0
                    end if
                    
                    ! Determinamos el color del continente basado en el promedio de saturación
                    if (promedio_saturacion >= 0 .and. promedio_saturacion <= 15) then
                        C_string = '#FFFFFF'  ! Blanco
                    elseif (promedio_saturacion > 15 .and. promedio_saturacion <= 30) then
                        C_string = '#0000FF'  ! Azul
                    elseif (promedio_saturacion > 30 .and. promedio_saturacion <= 45) then
                        C_string = '#00FF00'  ! Verde
                    elseif (promedio_saturacion > 45 .and. promedio_saturacion <= 60) then
                        C_string = '#FFFF00'  ! Amarillo
                    elseif (promedio_saturacion > 60 .and. promedio_saturacion <= 75) then
                        C_string = '#FF9900'  ! Anaranjado
                    elseif (promedio_saturacion > 75 .and. promedio_saturacion <= 100) then
                        C_string = '#FF0000'  ! Rojo
                    end if

                    write(p_string, '(I8)') promedio_saturacion
                    contador_promedio_continente = contador_promedio_continente + 1
                    promedio_continente(contador_promedio_continente) = trim(continentes(contador_continente))
                    contador_promedio_cantidad = contador_promedio_cantidad + 1
                    promedio_cantidad(contador_promedio_cantidad) = promedio_saturacion
                    write(10, '(A)') 'n' // trim(adjustl(i_string)) // ' [label="' // trim(continentes(contador_continente)) // '\n' // trim(adjustl(p_string)) //'%'// '", fillcolor="' // trim(adjustl(C_string)) // '"];'


                else

                end if    
            end do
            ! Determinar el continente con el menor promedio
            print*, "continentes sacados del promedio: "
            do i = 1, contador_promedio_continente
                print *, i, trim(promedio_continente(i))
            end do
            print*, "cantidad sacados del promedio: "
            do i = 1, contador_promedio_cantidad
                print *, i, promedio_cantidad(i)
            end do

            ! Inicialización de variables
            promedio_menor = promedio_cantidad(1)
            posicion_menor = 1

            ! Buscar el menor valor y su posición usando un bucle y `if`
            do i = 1, contador_promedio_cantidad
                if (promedio_cantidad(i) < promedio_menor) then
                    promedio_menor = promedio_cantidad(i)
                    posicion_menor = i
                end if
            end do
            print *,"posicion", posicion_menor, "MENOR: ", promedio_menor
            pMnombre = trim(promedio_continente(posicion_menor))
            print*, "continente menor: ", trim(pMnombre)
            ! Inicializar variables para buscar el país con el menor porcentaje
            real_saturacion_menor = 100
            j = 0

            ! Buscar el país con el menor porcentaje dentro del continente menor
            do i = 1, num_paises
                if (trim(paises(i)) /= 'continente') then
                    ! Verificar si el país pertenece al continente menor
                    if (trim(paises_continente(i)) == trim(pMnombre)) then
                        j = j + 1
                        ! Eliminar el símbolo de porcentaje y convertir el valor a real
                        saturacion_sin_porcentaje = trim(adjustl(saturacion(j)))
                        saturacion_sin_porcentaje = saturacion_sin_porcentaje(1:len_trim(saturacion_sin_porcentaje)-1)  ! Eliminar el último carácter (%)
                        read(saturacion_sin_porcentaje, *) real_saturacion  ! Convertir a número real
                        ! Verificar si el porcentaje es el menor encontrado
                        if (real_saturacion < real_saturacion_menor) then
                            real_saturacion_menor = real_saturacion
                            pais_menor_porc = trim(paises(i))
                        end if
                    end if
                end if
            end do
            ! Imprimir el país con el menor porcentaje
            print *, "pais_menor_porc: ", trim(pais_menor_porc)

             !busacar la posición del continente menor en la lista completa de paises
            do i = 1, contador_pais
                if (trim(Seleccionar_pais(i)) == trim(pais_menor_porc)) then
                    exit
                else
                    posicion_menor_paiscompleto = posicion_menor_paiscompleto + 1
                end if
                
            end do
            print*, "posicion del pais menor: ", posicion_menor_paiscompleto
            poblacion_grafica = trim(adjustl(poblacion(posicion_menor_paiscompleto)))
            print *, "poblacion_grafica: ", trim(poblacion_grafica)
            bandera_grafica = trim(bandera(posicion_menor_paiscompleto))
            print *, "bandera_grafica: ", trim(bandera_grafica)
            
            !print *, "porcentaje: ", real_saturacion_menor
            ! Nodos hojas (países)
            j=0
            do i = 1, num_paises
                if (trim(paises(i)) /= 'continente') then
                    ! Determinamos el color basado en el valor de saturacion(j)
                    j = j + 1
                    ! Eliminar el símbolo de porcentaje y convertir el valor a real
                    real_saturacion = 0  ! Inicializamos a un valor por defecto
                    saturacion_sin_porcentaje = trim(adjustl(saturacion(j)))
                    saturacion_sin_porcentaje = saturacion_sin_porcentaje(1:len_trim(saturacion_sin_porcentaje)-1)  ! Eliminar el último carácter (%)
                    read(saturacion_sin_porcentaje, *) real_saturacion  ! Convertir a número real

                    ! Determinamos el color basado en el valor de real_saturacion
                    if (real_saturacion >= 0 .and. real_saturacion <= 15) then
                        C_string = '#FFFFFF'  ! Blanco
                    elseif (real_saturacion > 15 .and. real_saturacion <= 30) then
                        C_string = '#0000FF'  ! Azul
                    elseif (real_saturacion > 30 .and. real_saturacion <= 45) then
                        C_string = '#00FF00'  ! Verde
                    elseif (real_saturacion > 45 .and. real_saturacion <= 60) then
                        C_string = '#FFFF00'  ! Amarillo
                    elseif (real_saturacion > 60 .and. real_saturacion <= 75) then
                        C_string = '#FF9900'  ! Anaranjado
                    elseif (real_saturacion > 75 .and. real_saturacion <= 100) then
                        C_string = '#FF0000'  ! Rojo
                    end if

                    write(j_string, '(I0)') j+num_continentes
                    write(10, '(A)') 'n' // trim(adjustl(j_string))// ' [label="' // trim(paises(i)) // '\n' // trim(saturacion(j)) // '", fillcolor="' // trim(adjustl(C_string)) // '"];'
                else 
                    
                end if    
            end do

            ! Enlaces entre nodos
            do i = 1, num_continentes
                write(i_string, '(I0)') i
                write(10, '(A)') 'n0 -> n' // trim(i_string) // ';'
            end do
            !write(10, '(A)') 'n0 -> n2;'
            
            !enlazar los demas nodos
            j=0
            contador_continente = 0
            do i = 1, num_paises
                if (trim(paises(i)) /= 'continente') then
                    ! Determinamos el color basado en el valor de saturacion(j)
                    j = j + 1
                    write(j_string, '(I0)') j+num_continentes
                    write(Contador_continente_string, '(I0)') contador_continente
                    write(10, '(A)') 'n' // trim(Contador_continente_string) //  ' -> n' // trim(adjustl(j_string))// ';'
                else 
                    contador_continente = contador_continente + 1
                end if    
            end do
            ! Cierre del archivo DOT
            write(10, '(A)') '}'
            
            close(10)
            
            print *, 'Archivo DOT generado: grafo.dot'
        end subroutine generar_dot

        function itoa(num) result(str)
            implicit none
            integer, intent(in) :: num
            character(len=20) :: str

            write(str, '(I0)') num  ! Convierte el entero 'num' a cadena
        end function itoa
end program analizador_lexico