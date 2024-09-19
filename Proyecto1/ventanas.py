from tkinter import *
from tkinter import filedialog
from tkinter import messagebox
import os 
import subprocess
from PIL import Image, ImageTk


def Abrir():
    
    Abrir = filedialog.askopenfilename(initialdir = "C:\\Users\\Marro\\Documents\\yon\\CUARTO SEMESTRE\\LAB LENGUAJES FORMALES\\-LFP-2S24Proyectos_202300813",title = "Elige un archivo",filetypes = (("archvios org","*.org"),("todos los archivos","*.*")))
    if Abrir: #lugar donde se guardo el directorio
        try:
            with open(Abrir, "r") as archivo:
                leer = archivo.read()
                entrada.delete(1.0, END)  #se limpia previo al cargar al texto
                entrada.insert(END, leer)    # Insertamos el contenido del archivo en el TEXT
        except:
            print("Error al abrir el archivo")

def mostrar_grafica():
    os.system('dot -Tpng grafo.dot -o grafo.png')
    ruta_imagen = "grafo.png"  # Ruta de la imagen generada por el programa Fortran
    if os.path.exists(ruta_imagen):
        img = Image.open(ruta_imagen)
        
        # Tamaño del contenedor de la imagen
        width_container, height_container = 400, 400
        
        # Obtener dimensiones originales de la imagen
        img_width, img_height = img.size
        
        # Calcular la relación de aspecto de la imagen
        aspect_ratio = img_width / img_height
        
        # Redimensionar manteniendo la relación de aspecto
        if img_width > img_height:
            new_width = width_container
            new_height = int(new_width / aspect_ratio)
        else:
            new_height = height_container
            new_width = int(new_height * aspect_ratio)
        
        # Redimensionar la imagen
        img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
        
        img_tk = ImageTk.PhotoImage(img)
        LUGAR_GRAFICA.config(image=img_tk)
        LUGAR_GRAFICA.image = img_tk  # Mantener referencia de la imagen para evitar que se recoja por el garbage collector
    else:
        LUGAR_GRAFICA.config(text="no se puede generar la grafica debido a que se encontraron errores")

def enviar_datos():

    
    data = entrada.get("1.0", END).strip()
    print(f"Contenido enviado a Fortran:\n{data}")
    resultado = subprocess.run(
        ["./Proyecto1.exe"], #RUTA DEL EJECTUBLE DE FORTRAN
        input = data, #la data que se manda a fortran
        stdout = subprocess.PIPE,  # la data que viene de fortran
        stderr=subprocess.PIPE,  # Capturar también los errores   
        text= True # que la salida se maneje como texto 
    )
    salida_fortran = resultado.stdout.strip()

    pais_menor_porc = None
    poblacion_grafica = None
    ruta_bandera_grafica = None
    
     # Procesar la salida para obtener los valores
    for line in salida_fortran.splitlines():
        if "pais_menor_porc" in line:
            pais_menor_porc = line.split(":")[-1].strip()
        elif "poblacion_grafica" in line:
            poblacion_grafica = line.split(":")[-1].strip()
        elif "bandera_grafica" in line:
            ruta_bandera_grafica = line.split(":")[-1].strip()
    
    # Actualizar los labels con los valores obtenidos
    if pais_menor_porc:
        label3.config(text=pais_menor_porc)
    if poblacion_grafica:
        label4.config(text=poblacion_grafica)
    
    ventana.update_idletasks()
    LUGAR_GRAFICA.delete(1.0, END)  #se limpia previo al cargar el archivo
    LUGAR_GRAFICA.insert(END, resultado.stdout)    # Insertamos el contenido del archivo en el TEXT

    # Llamar a la función para cargar la imagen
    if ruta_bandera_grafica:
        cargar_imagen(ruta_bandera_grafica)
    

def verificar_ruta(ruta):
    return os.path.isfile(ruta)

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

def cargar_imagen(ruta_imagen):
    if verificar_ruta(ruta_imagen):
        try:
            imagen = Image.open(ruta_imagen)
            imagen = imagen.resize((280, 200))  # Ajustar el tamaño si es necesario
            imagen_tk = ImageTk.PhotoImage(imagen)
            LUGAR_GRAFICA_pais.config(image=imagen_tk)
            LUGAR_GRAFICA_pais.image = imagen_tk  # Mantener una referencia a la imagen
        except Exception as e:
            print(f"Error al cargar la imagen: {e}")
    else:
        print(f"No se encontró el archivo en la ruta: {ruta_imagen}")

def mostrar_grafica_y_imagen():
    mostrar_grafica()  # Asumiendo que esta función ya está implementada
    enviar_datos()     # Llamar a enviar_datos para actualizar la imagen y datos
#creación de la ventana 
ventana = Tk() #creacion de la ventana o en si la raiz de todo
ventana.title("Proyecto 1_Brandon Marroquin_202300813") #titulo de la ventana
ventana.config(width=1350, height=750)#definir el tamaño de la ventana 
ventana.resizable(False, False)#definir el tamaño de la ventana pero fija para eso se declara false

boton1= Button(ventana, text="Analisis",command=enviar_datos, relief="groove", borderwidth=5,cursor="hand2")
boton1.place(x=630, y=300, width=100, height=50) #define la posición del boton

btn_mostrar = Button(ventana, text="Mostrar Gráfica", command=mostrar_grafica_y_imagen, relief="groove", borderwidth=5,cursor="hand2")
btn_mostrar.place(x=630, y=420, width=100, height=50) #define la ubicación del boton()
#label de texto
entrada= Text(ventana, relief="groove", borderwidth=5) #lugar de texto
entrada.place(x=20, y=30, width=550, height=650) #define la posición del lugar de texto
#label de grafica
LUGAR_GRAFICA= Label(ventana, bg="white", relief="groove", borderwidth=5) #un label para la grafica
LUGAR_GRAFICA.place(x=800, y=30, width=500, height=400) #define la posición del lugar de texto
#label de imagen del pais
LUGAR_GRAFICA_pais= Label(ventana, bg="white", relief="groove", borderwidth=5) #lugar para la imagen
LUGAR_GRAFICA_pais.place(x=1020, y=470, width=280, height=200) #define la posición del lugar de texto

# Ruta correcta a la imagen
ruta_imagen = os.path.join("C:", "bandera", "gt.png")
cargar_imagen(ruta_imagen)
#label de pais
label1= Label(ventana, text="País seleccionado: ", relief="groove", borderwidth=5, anchor="w") #lugar de texto
label1.place(x=800, y=500, width=120, height=30) #define la posición del lugar de texto
    
pais_menor_porc=""
label3= Label(ventana, text=pais_menor_porc, relief="groove", borderwidth=5, anchor="w") #lugar de texto
label3.place(x=918, y=500, width=100, height=30) #define la posición del lugar de texto
#label de población
label2= Label(ventana, text="Población: ", relief="groove", borderwidth=5, anchor="w") 
label2.place(x=800, y=550, width=80, height=30) #define la posición del lugar de texto
poblacion_grafica= ""
label4= Label(ventana, text=poblacion_grafica, relief="groove", borderwidth=5, anchor="w") 
label4.place(x=878, y=550, width=100, height=30) #define la posición del lugar de texto

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
