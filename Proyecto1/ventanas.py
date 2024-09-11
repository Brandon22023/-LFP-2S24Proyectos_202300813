from tkinter import *
from tkinter import filedialog
from tkinter import messagebox
import os 
import subprocess
def Abrir():
    Abrir = filedialog.askopenfilename(initialdir = "C:\\Users\\Marro\\Documents\\yon\CUARTO SEMESTRE\\LAB LENGUAJES FORMALES\\-LFP-2S24Proyectos_202300813",title = "Elige un archivo",filetypes = (("archvios org","*.org"),("todos los archivos","*.*")))
    if Abrir: #lugar donde se guardo el directorio
        try:
            with open(Abrir, "r") as archivo:
                leer = archivo.read()
                entrada.delete(1.0, END)  #se limpia previo al cargar al 
                entrada.insert(END, leer)    # Insertamos el contenido del archivo en el TEXT
        except:
            print("Error al abrir el archivo")

def enviar_datos():
    
    data = entrada.get("1.0", END).strip()
    resultado = subprocess.run(
        ["./Proyecto1.exe"], #RUTA DEL EJECTUBLE DE FORTRAN
        input = data, #la data que se manda a fortran
        stdout = subprocess.PIPE,  # la data que viene de fortran
        stderr=subprocess.PIPE,  # Capturar también los errores   
        text= True # que la salida se maneje como texto 
    )
    LUGAR_GRAFICA.insert(END, resultado.stdout)
    

def Guardar():
    file_path = filedialog.asksaveasfilename(defaultextension=".txt", 
                                             filetypes=[("Text files", "*.txt"), ("All files", "*.*")])

    if file_path:  # Si el usuario selecciona un archivo
        # Comprobamos si el archivo ya existe
        if os.path.exists(file_path):
            # Preguntamos al usuario si desea sobrescribirlo
            respuesta = messagebox.askyesno("Sobrescribir archivo", "El archivo ya existe. ¿Deseas sobrescribirlo?")
            if not respuesta:  # Si el usuario elige no sobrescribir, salir de la función
                return
        
        # Si el archivo no existe o el usuario aceptó sobrescribirlo, guardamos el archivo
        try:
            with open(file_path, 'w') as file:
                file.write(entrada.get(1.0, END))  # Obtenemos el contenido del Text widget
            messagebox.showinfo("Éxito", "El archivo ha sido guardado con éxito.")
        except Exception as e:
            messagebox.showerror("Error", f"Hubo un error al guardar el archivo: {e}")
def GuardarComo():
    file_path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt"), ("All files", "*.*")])
    if file_path:
        with open(file_path, 'w') as file:
            file.write(entrada.get(1.0, END))

def ventana_datos():
    #Ventana para los datos 
    ventana_datos = Tk()
    ventana_datos.title("Datos")
    ventana_datos.config(width=600, height=200)
    ventana_datos.resizable(False, False)

        #label de datos
    label1= Label(ventana_datos, text="NOMBRE: BRANDON ANTONIO MARROQUIN PÉREZ "+ 
                "\nCARNET: 202300813"+
                "\nCURSO: LABORATORIO LENGUAJES FORMALES Y DE PROGRAMACION Sección B-"+
                "\nCARRERA: INGENIERIA EN CIENCIAS Y SISTEMAS"
                "\nSEMESTRE: 4", relief="groove", borderwidth=5, justify="left") #lugar de texto
    label1.place(x=20, y=20, width=500, height=180) #define la posición del lugar de texto
    ventana_datos.mainloop()


#creación de la ventana 
ventana = Tk() #creacion de la ventana o en si la raiz de todo
ventana.title("Proyecto 1_Brandon Marroquin_202300813") #titulo de la ventana
ventana.config(width=1350, height=750)#definir el tamaño de la ventana 
ventana.resizable(False, False)#definir el tamaño de la ventana pero fija para eso se declara false

boton1= Button(ventana, text="Analisis",command=enviar_datos, relief="groove", borderwidth=5,cursor="hand2")
boton1.place(x=630, y=300, width=100, height=50) #define la posición del boton
#label de texto
entrada= Text(ventana, relief="groove", borderwidth=5) #lugar de texto
entrada.place(x=20, y=30, width=550, height=650) #define la posición del lugar de texto
#label de grafica
LUGAR_GRAFICA= Label(ventana, bg="white", relief="groove", borderwidth=5) #un label para la grafica
LUGAR_GRAFICA.place(x=800, y=30, width=500, height=400) #define la posición del lugar de texto
#label de imagen del pais
LUGAR_GRAFICA_pais= Label(ventana, bg="white", relief="groove", borderwidth=5) #lugar para la imagen
LUGAR_GRAFICA_pais.place(x=1020, y=470, width=280, height=200) #define la posición del lugar de texto
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
filename2 = Menu(filename, tearoff = 0)
menu1.add_cascade(label = "Menu", menu = filename) #menu llamado menu
menu1.add_cascade(label = "Acerca de", command=ventana_datos) #menu llamado Acerca de
menu1.add_cascade(label = "Salir", command=ventana.destroy) #menu llamado Salir
#les creo los sub menus
filename.add_command(label = "Abrir", command = Abrir) #sub menu llamado Abrir para el menu menu
filename.add_command(label = "Guardar", command = Guardar) #sub menu llamado Guardar para el menu menu
filename.add_command(label = "Guardar como...", command = GuardarComo) #sub menu llamado Guardar como para el menu menu




ventana.mainloop()#siempre sera la ultima linea de codigo debido a que es un bucle que esta dibujando la ventana constantemente
#fin de la ventana
