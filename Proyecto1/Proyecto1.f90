program analizador_lexico
    implicit none
    integer :: i, len, linea, columna, estado, puntero, numErrores,file_unit,ios
    integer :: espacio_texto
    character(len=10000) :: contenido, cadena, buffer
    character(len=1) :: char 
    character(len=100) :: tkn
    character(len=1), dimension(26) :: A 
    character(len=1), dimension(26) :: M
    character(len=1), dimension(3) :: S 
    character(len=1) :: char_error
    integer, dimension(100,4) :: errores 
    character(len=10000) :: entrada
    read(*, '(A)') entrada
    A = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    M = ['a','b','c','d','d','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    S = [':','{','}']
    estado = 0
    puntero = 1
    columna = 1
    linea = 1
    numErrores = 0
    contenido = ""

    contenido = trim(entrada)
    len = len_trim(contenido)
    ! close(file_unit)


    do while(puntero <= len)
        char = contenido(puntero:puntero)
    
     

        if (ichar(char) == 10) then
        !salto de linea
            columna = 1
            linea = linea +1
            puntero = puntero + 1;
         
        elseif(ichar(char) == 9) then
        !tabulacion
            columna = columna + 4
            puntero = puntero + 4
        elseif(ichar(char) == 32) then
           ! espacio en blacno
           columna = columna + 1
           puntero = puntero + 1

        else 

            select case (estado)
                case (0)
                ! VERIFICAR QUE VENGA EN MI LENGUAJE UNA MAYUSCULA EN LA PRIMERA PON
                    if (any(char == M)) then 
                        estado = 1
                        columna = columna + 1
                        tkn = tkn // char
                    else
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if
                    puntero = puntero + 1
                case (1)
                    if (any(char == M)) then
                        estado = 1
                        columna = columna + 1
                        tkn = tkn //char 
                    else if (any(char == S)) then
                        columna = columna + 1
                        estado = 2
                        !agregar a tabla de tokens el tkn y el char
                        tkn = ""
                    else
                        numErrores = numErrores + 1
                        errores(numErrores,:) = (/ ichar(char),69, columna, linea /)
                        columna = columna + 1
                        estado = 1
                    
                    end if        
                    puntero = puntero + 1
                case (2)
                    if (any(char == S)) then
                        columna = columna + 1
                        estado = 3
                        ! agregar el char
                    end if
                    puntero = puntero + 1
                    
                case (3)
                    puntero = puntero + 1
                    if (any(char == M)) then 
                        estado = 3
                        columna = columna + 1
                        tkn = tkn // char
                    else if (any(char == S)) then
                        columna = columna + 1
                        estado = 4
                        !agregar a tabla de tokens el tkn y el char
                        tkn = ""
                    end if
                case (4)
                    puntero = puntero + 1
                    
            end select
        end if
    end do

    if (numErrores > 0 ) then
   
       do i=1, numErrores 
            char_error = achar(errores(i,1))
            print *, "Error en caracter: ", char_error, " Linea: ", errores(i,4), "Columna: ", errores(i,3)
        end do
    else 
        print *, trim("No hubieron Errores")
    end if
end program analizador_lexico