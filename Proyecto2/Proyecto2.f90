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
    integer :: CN !NUEVOS
    integer :: CP,P_PB!NUEVOS
    character(len=20) :: continentes(20) ! Arreglo de 20 continentes con longitud de 20 caracteres
    character(len=20) :: paises(100) ! Arreglo de 100 paises con longitud de 20 caracteres
    character(len=20) :: saturacion(100)
    character(len=20) :: Seleccionar_pais(100)
    character(len=50) :: poblacion(100)
    character(len=1000) :: bandera(100)
    character(len=1000) :: paises_continente(100)
    character(len=20) :: promedio_continente(100), P_CP(100),PPB(100) !NUEVOS
    real(kind=4) :: promedio_cantidad(100)
    real(kind=4) :: RP_SINP(100)
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
        print *,"TKN:", trim(tkn), "  ", estado
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
    if (numErrores > 0) then
       print *, "aun no se puede mostrar algo"
    else
        print *, "No hay errores en el código."
    end if

    


   
   

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


        
        function itoa(num) result(str)
            implicit none
            integer, intent(in) :: num
            character(len=20) :: str

            write(str, '(I0)') num  ! Convierte el entero 'num' a cadena
        end function itoa
end program analizador_lexico