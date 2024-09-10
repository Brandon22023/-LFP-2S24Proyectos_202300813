from tkinter import *
def analisis():
    print("analisis")
def Abrir():
    print("abriendo")
def Guardar():
    print("Guardando")
def GuardarComo():
    print("Guardando Como...")
def Acerca_de():
    print("")
    print("Nombre: Brandon Antonio Marroquin Pérez")
    print("Carnet: 202300813")
    print("Carrera: Ingeniería en Ciencias y Sistemas")
    print("Curso: LABORATORIO LENGUAJES FORMALES Y DE PROGRAMACION Sección B-")
    print("CUI: 3045062060114")
    print("Semestre: 4")

#creación de la ventana 
ventana = Tk() #creacion de la ventana o en si la raiz de todo
ventana.title("Proyecto 1_Brandon Marroquin_202300813") #titulo de la ventana
ventana.config(width=1350, height=750)#definir el tamaño de la ventana 
ventana.resizable(False, False)#definir el tamaño de la ventana pero fija para eso se declara false

boton1= Button(ventana, text="Analisis",command=analisis, relief="groove", borderwidth=5,cursor="hand2")
boton1.place(x=630, y=300, width=100, height=50) #define la posición del boton
#label de texto
text= Entry(ventana, bg="white", relief="groove", borderwidth=5) #lugar de texto
text.place(x=20, y=30, width=550, height=650) #define la posición del lugar de texto
#label de grafica
LUGAR_GRAFICA= Label(ventana, bg="white", relief="groove", borderwidth=5) #lugar de texto
LUGAR_GRAFICA.place(x=800, y=30, width=500, height=400) #define la posición del lugar de texto
#label de imagen del pais
LUGAR_GRAFICA= Label(ventana, bg="white", relief="groove", borderwidth=5) #lugar de texto
LUGAR_GRAFICA.place(x=1020, y=470, width=280, height=200) #define la posición del lugar de texto
#label de pais
label1= Label(ventana, text="País seleccionado: "+ "", relief="groove", borderwidth=5, anchor="w") #lugar de texto
label1.place(x=800, y=500, width=200, height=30) #define la posición del lugar de texto
#label de población
label2= Label(ventana, text="Población: "+ "", relief="groove", borderwidth=5, anchor="w") 
label2.place(x=800, y=550, width=200, height=30) #define la posición del lugar de texto

#Menu

#SE DEFINE EL MENU
menu1 = Menu(ventana)
ventana.config(menu = menu1)
ventana.config(bg="white")
#añado los menus
filename = Menu(menu1, tearoff = 0)
menu1.add_cascade(label = "Menu", menu = filename)
menu1.add_cascade(label = "Acerca de", command=Acerca_de)
menu1.add_cascade(label = "Salir", command=ventana.destroy)

#les creo los sub menus
filename.add_command(label = "Abrir", command = Abrir)
filename.add_command(label = "Guardar", command = Guardar)
filename.add_command(label = "Guardar como...", command = GuardarComo)

ventana.mainloop()#siempre sera la ultima linea de codigo debido a que es un bucle que esta dibujando la ventana constantemente
#fin de la ventana

#ventana.title("Interfaz Tkinter Con Fortran")

#tk.Label(ventana, text="Ingrese un valor").pack
#entrada = tk.Entry(ventana)
#entrada.pack()

#tk.Button(ventana, text="Enviar Datos a Fortran" ).pack()
#output_area = tk.Text(ventana,height=10, width=50)
#output_area.pack()
    
#ventana.mainloop()
