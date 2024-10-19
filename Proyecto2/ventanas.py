from tkinter import *
from tkinter import filedialog
from tkinter import messagebox
from tkinter import font, Menu, ttk
import os 
import subprocess
import webbrowser



Abrir = None

def Abrir():
    global Abrir
    Abrir = filedialog.askopenfilename(initialdir = "C:\\Users\\Marro\\Documents\\yon\\CUARTO SEMESTRE\\LAB LENGUAJES FORMALES\\-LFP-2S24Proyectos_202300813",title = "Elige un archivo",filetypes = (("archvios LFP","*.LFP"),("todos los archivos","*.*")))
    if Abrir: #lugar donde se guardo el directorio
        try:
            with open(Abrir, "r") as archivo:
                leer = archivo.read()
                entrada.delete(1.0, END)  #se limpia previo al cargar al texto
                entrada.insert(END, leer)    # Insertamos el contenido del archivo en el TEXT
        except:
            print("Error al abrir el archivo")



def enviar_datos():

    
    data = entrada.get("1.0", END).strip()
    print(f"Contenido enviado a Fortran:\n{data}")
    resultado = subprocess.run(
        ["./Proyecto2.exe"], #RUTA DEL EJECTUBLE DE FORTRAN
        input = data, #la data que se manda a fortran
        stdout = subprocess.PIPE,  # la data que viene de fortran
        stderr=subprocess.PIPE,  # Capturar también los errores   
        text= True # que la salida se maneje como texto 
    )
    # Verifica si hubo errores
    if resultado.stderr:
        messagebox.showerror("Error", f"Error en Fortran:\n{resultado.stderr}")
        return

    # Mostrar la salida en el lugar de la gráfica
    print(f"Contenido recibido de Fortran:\n{resultado.stdout}")  # Para verificar lo recibido en consola
    LUGAR_GRAFICA.delete(1.0, END)  # Limpia el área de texto anterior
    LUGAR_GRAFICA.insert(END, resultado.stdout)  # Inserta la salida recibida de Fortran
    # Llamar a la función para agregar los datos desde el archivo .txt a la tabla
    agregar_datos_desde_archivo()

  
    

def verificar_ruta(ruta_bandera_grafica):
    ruta_ajustada = os.path.normpath(ruta_bandera_grafica)
    print(f"Verificando ruta: {ruta_ajustada}")
    return os.path.isfile(ruta_ajustada)

def Guardar(file_path= None):
    global Abrir
    if Abrir:  # Si ya hay un archivo abierto
            try:
                with open(Abrir, 'w') as archivo:
                    archivo.write(entrada.get(1.0, END))  # Guardamos el contenido del Text widget
                messagebox.showinfo("Éxito", "Los cambios han sido guardados en el archivo existente.")
            except Exception as e:
                messagebox.showerror("Error", f"Hubo un error al guardar el archivo: {e}")
    else:
            # Si no hay un archivo abierto, se pide al usuario que seleccione uno
            Abrir = filedialog.asksaveasfilename(defaultextension=".txt", 
                                                        filetypes=[("ARCHIVO", "*.ORG"),("Text files", "*.txt"), ("All files", "*.*")])
            if Abrir:  # Si el usuario selecciona un archivo
                try:
                    with open(Abrir, 'w') as archivo:
                        archivo.write(entrada.get(1.0, END))  # Guardamos el contenido del Text widget
                    messagebox.showinfo("Éxito", "El archivo ha sido guardado con éxito.")
                except Exception as e:
                    messagebox.showerror("Error", f"Hubo un error al guardar el archivo: {e}")
                
def GuardarComo():
    file_path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("ARCHIVO", "*.ORG"), ("Text files", "*.txt"), ("All files", "*.*")])
    if file_path:
        with open(file_path, 'w') as file:
            file.write(entrada.get(1.0, END))
def NUEVO():
    
    global Abrir
    # Verificar si el área de edición tiene contenido
    if entrada.get(1.0, END).strip():  # Si hay contenido en el editor
        respuesta = messagebox.askyesnocancel("Guardar cambios", "¿Deseas guardar los cambios antes de limpiar?")
        if respuesta:  # Si la respuesta es 'Sí'
            if Abrir:  # Si ya hay un archivo abierto, lo guarda directamente
                GuardarComo()
            else:  # Si no hay un archivo abierto, se debe preguntar el nombre y el path
                file_path = filedialog.asksaveasfilename(defaultextension=".txt",
                                                         filetypes=[("Text files", "*.txt"), ("All files", "*.*")])
                if file_path:  # Si el usuario selecciona un archivo
                    with open(file_path, 'w') as archivo:
                        archivo.write(entrada.get(1.0, END))  # Guardamos el contenido del Text widget
                    messagebox.showinfo("Éxito", f"Archivo guardado en {file_path}")
                    Abrir = file_path  # Actualizar el archivo abierto con el nuevo path

        elif respuesta is None:  # Si elige 'Cancelar'
            return  # No hacer nada y volver

    # Limpiar el área de edición
    Abrir = None  # Reseteamos el archivo abierto actual
    entrada.delete(1.0, END)  # Limpiamos el área de texto
    messagebox.showinfo("Nuevo archivo", "El área de edición ha sido limpiada.")
def tokens():
    try:
        ruta_toknes = 'C:\\Users\\Marro\\Documents\\yon\\CUARTO SEMESTRE\\LAB LENGUAJES FORMALES\\-LFP-2S24Proyectos_202300813\\Proyecto2\\tokens.html'
        
        # Verificar si el archivo existe
        if os.path.exists(ruta_toknes):
            # Abrir el archivo HTML en el navegador predeterminado
            webbrowser.open(f'file://{os.path.abspath(ruta_toknes)}')
        else:
            print("Error: El archivo no existe.")
    except Exception as e:
        print(f"Error al abrir el archivo: {e}")


# Función para agregar datos a la tabla
def agregar_datos_a_tabla(datos):
    for fila in datos:
        tabla.insert("", "end", values=fila)  # Insertar cada fila en la tabla
# Función para agregar datos a la tabla
def agregar_datos_desde_archivo():
    errors_ruta = "C:\\Users\\Marro\\Documents\\yon\\CUARTO SEMESTRE\\LAB LENGUAJES FORMALES\\-LFP-2S24Proyectos_202300813\\Proyecto2\\TODOS_LOS_ERRORES.txt"
    # Limpiar la tabla antes de agregar nuevos datos
    for item in tabla.get_children():
        tabla.delete(item)
    try:
        # Abrir el archivo y leer todas las líneas
        with open(errors_ruta, "r") as archivo:
            for linea in archivo:
                datos = linea.strip().split(",")  # Separar los datos por coma
                if len(datos) == 5:  # Verificar que haya exactamente 5 columnas
                    tabla.insert("", "end", values=datos)  # Insertar la fila en la tabla
                else:
                    print(f"Línea con formato incorrecto: {linea}")  # Si la línea no tiene 5 columnas, notificar
    except FileNotFoundError:
        messagebox.showerror("Error", "El archivo no fue encontrado.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo leer el archivo: {e}")

color_boton = "#3fe3d2"
color_label = "#b9f9f2"
color_fondo= "#bef8d6"

#creación de la ventana 
ventana = Tk() #creacion de la ventana o en si la raiz de todo
ventana.title("Proyecto 2_Brandon Marroquin_202300813") #titulo de la ventana
ventana.config(width=1350, height=750)#definir el tamaño de la ventana 
ventana.resizable(False, False)#definir el tamaño de la ventana pero fija para eso se declara false



#btn_mostrar = Button(ventana, text="Mostrar Gráfica", font=("Times New Roman", 12), command=mostrar_grafica_y_imagen, relief="groove", borderwidth=5,cursor="hand2", fg="white", bg=color_boton)
#btn_mostrar.place(x=630, y=420, width=120, height=50) #define la ubicación del boton()
#label de texto
entrada= Text(ventana, relief="groove",font=("Times New Roman", 12), borderwidth=5, bg=color_label) #lugar de texto
entrada.place(x=20, y=15, width=550, height=415) #define la posición del lugar de texto
#label de grafica
LUGAR_GRAFICA= Text(ventana, bg="white", relief="groove", borderwidth=5) #un label para la grafica
LUGAR_GRAFICA.place(x=600, y=30, width=700, height=400) #define la posición del lugar de texto


# Tabla
tabla = ttk.Treeview(ventana, columns=("Columna 1", "Columna 2", "Columna 3", "Columna 4", "Columna 5"), show="headings")
tabla.heading("Columna 1", text="Tipo")
tabla.heading("Columna 2", text="Linea")
tabla.heading("Columna 3", text="Columna")
tabla.heading("Columna 4", text="Token")
tabla.heading("Columna 5", text="Descripcion")
tabla.place(x=20, y=450, width=1280, height=250)  # Define la posición y el tamaño de la tabla


#Menu
#SE DEFINE EL MENU
menu1 = Menu(ventana)
ventana.config(menu = menu1, bg= color_fondo)
#ventana.config(bg="write")

fuente_personalizada = font.Font(family="Times New Roman", size=12)
# Aplicar fuente a los menús
ventana.option_add("*Menu.Font", fuente_personalizada)
#añado los menus
filename = Menu(menu1, tearoff = 0)
filename2 = Menu(filename, tearoff = 0)
menu1.add_cascade(label = "Archivo", menu = filename) #menu llamado menu
menu1.add_cascade(label = "Analisis", command=enviar_datos) #menu para analizar la informacion
menu1.add_cascade(label = "Tokens", command=tokens) #menu llamado Acerca de
#les creo los sub menus
filename.add_command(label = "Nuevo", command = NUEVO) #sub menu llamado nuevo para el menu menu
filename.add_command(label = "Abrir", command = Abrir) #sub menu llamado Abrir para el menu menu
filename.add_command(label = "Guardar", command = Guardar) #sub menu llamado Guardar para el menu menu
filename.add_command(label = "Guardar como...", command = GuardarComo) #sub menu llamado Guardar como para el menu menu
filename.add_command(label = "salir", command = ventana.destroy) #nos termina cerrando la ventana



ventana.mainloop()#siempre sera la ultima linea de codigo debido a que es un bucle que esta dibujando la ventana constantemente
#fin de la ventana