#Library
import pyodbc
from tkinter import *
from tkinter import messagebox
from tkinter import ttk
from PIL import Image, ImageTk

#TODO=============================================================================== ODBC SECTION
# Define Server & Database
server = 'LAPTOP-JDAPPLRS\SQLEXPRESS'
database = 'Final_Project'

# Connect Python to SQL Server Database
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server='+server+';'
                      'Database='+database+';'
                      'Trusted_Connection=yes;')

# Create Cursor
my_cursor = conn.cursor()

#TODO================================================================================ FUNCTION SECTION
# Function Login as Admin
def login_admin():
    login_window.destroy()
    global login_admin_window
    login_admin_window = Tk()
    login_admin_window.title("Login as Admin")
    login_admin_window.geometry("400x200")
    login_admin_window.config(bg="#76D7C4")

    def validate_login():
        admin_username = username.get()
        admin_password = password.get()
        if admin_username == "admin" and admin_password == "admin":
            admin_menu()
        else:
            messagebox.showwarning("Login Notification", "Username or Password you've entered is wrong!")

    #heading label
    login_heading_label = Label(login_admin_window, text="LOGIN PAGE\nPlease insert your username & password!", bg="#76D7C4", font=('Open Sans Semibold', 11, 'bold'))
    login_heading_label.place(relx=0.1, rely=0.05, relwidth=0.8, relheight=0.2)

    #username label and text entry box
    Label(login_admin_window, text="Username:").place(relx=0.15,rely=0.35,relwidth=0.2,relheight=0.1)
    username = StringVar()
    Entry(login_admin_window, textvariable=username).place(relx=0.35,rely=0.35,relwidth=0.5,relheight=0.1)  
    
    #password label and password entry box
    Label(login_admin_window,text="Password:").place(relx=0.15,rely=0.5,relwidth=0.2,relheight=0.1)  
    password = StringVar()
    Entry(login_admin_window, textvariable=password).place(relx=0.35,rely=0.5,relwidth=0.5,relheight=0.1)  

    #login button
    Button(login_admin_window, text="Login", command=validate_login).place(relx=0.35,rely=0.7,relwidth=0.3,relheight=0.2)

    login_admin_window.mainloop()

# Function Patient Table    
def Patient():
    # Declaration
    PatientId = StringVar()
    PatientName = StringVar()
    PatientGender = StringVar()
    PatientAge = StringVar()
    PatientAddress = StringVar()
    PatientPhone = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        server = 'LAPTOP-JDAPPLRS\SQLEXPRESS'
        database = 'Final_Project'
        conn = pyodbc.connect('Driver={SQL Server};'
                      'Server='+server+';'
                      'Database='+database+';'
                      'Trusted_Connection=yes;')
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Patient")
        result=my_cursor.fetchall()
        if len(result)!=0:
            patient_display_treeview.delete(*patient_display_treeview.get_children())
            for row in result:
                patient_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = patient_display_treeview.focus()
        patient_info = patient_display_treeview.item(view_info)
        row = (patient_info['values'])
        PatientId.set(row[0])
        PatientName.set(row[1])
        PatientGender.set(row[2])
        PatientAge.set(row[3])
        PatientAddress.set(row[4])
        PatientPhone.set(row[5])

    # Patient main frame
    patient_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    patient_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    patient_title = Label(patient_frame, text="Laboratorium Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    patient_title.pack(side=TOP, fill=X)

    # Patient frame left inside main patient frame
    patient_frame_left = Frame(patient_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    patient_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (patient_frame_left)
    left_title = Label(patient_frame_left, text="Manage Patient", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    patient_id_label = Label(patient_frame_left, text="Patient ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_id_label.grid(row=1, column=0, padx=7, pady=10, sticky="W")
    patient_id_entry = Entry(patient_frame_left, textvariable=PatientId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")
    patient_id_entry.insert(0, "PT")

    patient_name_label = Label(patient_frame_left, text="Patient Name:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_name_label.grid(row=2, column=0, padx=7, pady=10, sticky="W")
    patient_name_entry = Entry(patient_frame_left, textvariable=PatientName, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_name_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    patient_gender_label = Label(patient_frame_left, text="Patient Gender:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_gender_label.grid(row=3, column=0, padx=7, pady=10, sticky="W")
    patient_gender_combo = ttk.Combobox(patient_frame_left, textvariable=PatientGender, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    patient_gender_combo['values'] = ("Male", "Female")
    patient_gender_combo.grid(row=3, column=1, padx=17, pady=10)

    patient_age_label = Label(patient_frame_left, text="Patient Age:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_age_label.grid(row=4, column=0, padx=7, pady=10, sticky="W")
    patient_age_entry = Entry(patient_frame_left, textvariable=PatientAge, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_age_entry.grid(row=4, column=1, padx=17, pady=10, sticky="W")

    patient_address_label = Label(patient_frame_left, text="Patient Address:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_address_label.grid(row=5, column=0, padx=7, pady=10, sticky="W")
    patient_address_entry = Entry(patient_frame_left, textvariable=PatientAddress, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_address_entry.grid(row=5, column=1, padx=17, pady=10, sticky="W")

    patient_phone_label = Label(patient_frame_left, text="Patient Phone:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    patient_phone_label.grid(row=6, column=0, padx=7, pady=10, sticky="W")
    patient_phone_entry = Entry(patient_frame_left, textvariable=PatientPhone, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_phone_entry.grid(row=6, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_patient():
        PatientId = patient_id_entry.get()
        PatientName = patient_name_entry.get()
        PatientGender = patient_gender_combo.get()
        PatientAge = patient_age_entry.get()
        PatientAddress = patient_address_entry.get()
        PatientPhone = patient_phone_entry.get()

        # Open DB
        server = 'LAPTOP-JDAPPLRS\SQLEXPRESS'
        database = 'Final_Project'
        conn = pyodbc.connect('Driver={SQL Server};'
                      'Server='+server+';'
                      'Database='+database+';'
                      'Trusted_Connection=yes;')
        my_cursor = conn.cursor()

        # Operation
        my_cursor.execute("INSERT INTO Patient VALUES (?,?,?,?,?,?)", PatientId, PatientName, PatientGender, PatientAge, PatientAddress, PatientPhone)

        # Close DB
        conn.commit()
        display_data()
        conn.close()

        # Notification
        messagebox.showinfo("Laboratorium", "Data succesfully inserted to the database!")

    # Function to clear entry box
    def clear_patient():
        patient_id_entry.delete(0, END)
        patient_name_entry.delete(0, END)
        patient_gender_combo.delete(0, END)
        patient_age_entry.delete(0, END)
        patient_address_entry.delete(0, END)
        patient_phone_entry.delete(0, END)

    # Function to close the program
    def exit_patient():
        exit = messagebox.askyesno("Laboratorium", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
            return

    # Button main frame
    patient_button_frame = Frame(patient_frame_left, bd=4, relief=RIDGE, bg="white")
    patient_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(patient_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_patient).grid(row=0, column=0, padx=6, pady=3)
    Button(patient_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4").grid(row=0, column=1, padx=6, pady=3)
    Button(patient_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4").grid(row=1, column=0, padx=6, pady=3)
    Button(patient_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_patient).grid(row=1, column=1, padx=6, pady=3)

    # Patient frame right inside main patient frame
    patient_frame_right = Frame(patient_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    patient_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (patient_frame_right)
    right_title = Label(patient_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    patient_search_combo = ttk.Combobox(patient_frame_right, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    patient_search_combo['values'] = ("ID", "Name")
    patient_search_combo.grid(row=0, column=1, padx=5, pady=10)
    
    patient_search_entry = Entry(patient_frame_right, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    patient_search_button = Button(patient_frame_right, text="SEARCH", width=12, height=2, )
    patient_search_button.grid(row=0, column=3, padx=5, pady=10)
    patient_search_button = Button(patient_frame_right, text="EXIT", width=12, height=2, command=exit_patient)
    patient_search_button.grid(row=0, column=4, padx=5, pady=10)

    # Display frame
    patient_display_frame = Frame(patient_frame_right, bd=4, relief=RIDGE, bg="white")
    patient_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(patient_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(patient_display_frame, orient=VERTICAL)
    patient_display_treeview = ttk.Treeview(patient_display_frame, columns=("PatientId", "PatientName", "PatientGender", "PatientAge", "PatientAddress", "PatientPhone"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=patient_display_treeview.xview)
    scroll_y.config(command=patient_display_treeview.yview)
    patient_display_treeview.heading("PatientId", text="PatientId")
    patient_display_treeview.heading("PatientName", text="PatientName")
    patient_display_treeview.heading("PatientGender", text="PatientGender")
    patient_display_treeview.heading("PatientAge", text="PatientAge")
    patient_display_treeview.heading("PatientAddress", text="PatientAddress")
    patient_display_treeview.heading("PatientPhone", text="PatientPhone")
    patient_display_treeview['show'] = 'headings'
    patient_display_treeview.column("PatientId", width=100, anchor=CENTER)
    patient_display_treeview.column("PatientName", width=150, anchor=CENTER)
    patient_display_treeview.column("PatientGender", width=100, anchor=CENTER)
    patient_display_treeview.column("PatientAge", width=100, anchor=CENTER)
    patient_display_treeview.column("PatientAddress", width=150, anchor=CENTER)
    patient_display_treeview.column("PatientPhone", width=100, anchor=CENTER)
    patient_display_treeview.pack(fill=BOTH, expand=1)
    patient_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()
    
    

    
    
    















# Function Menu Admin
def admin_menu():
    login_admin_window.destroy()
    global admin_menu_window
    admin_menu_window = Tk()
    admin_menu_window.title("Admin Menu")
    admin_menu_window.geometry("1350x750+0+0")

    # Declare menu
    my_menu = Menu(admin_menu_window)
    admin_menu_window.config(menu = my_menu)

    # Creating menu bars
    open_menu = Menu(my_menu)
    my_menu.add_cascade(label="Table", menu=open_menu)
    open_menu.add_command(label="Patient")
    open_menu.add_command(label="Staff")
    open_menu.add_command(label="Post")
    open_menu.add_command(label="Transaction")
    open_menu.add_command(label="Schedule")
    open_menu.add_command(label="Result")

    Patient()
    
    admin_menu_window.mainloop()
    
#TODO================================================================================ LOGIN SECTION
# Creating the main window
login_window = Tk()
login_window.title("Laboratorium")
login_window.minsize(width=625,height=418)
login_window.maxsize(width=625,height=418)
login_window.geometry("625x418")

#FF7F50-light orange
#34495E-Dark blue

# Adding a background image
background_image =ImageTk.PhotoImage(Image.open("coronavirus-test-kit.jpg"))
background_label = Label(image=background_image)
background_label.pack()

# Login frame
login_frame = Frame(login_window, bg="#76D7C4", bd=4, relief=RIDGE)
login_frame.place(relx=0.55,rely=0.15,relwidth=0.4,relheight=0.7)

# Login label
login_label = Label(login_frame, text="LABORATORIUM\nLogin Page", bg='white', fg='black', font=('Open Sans Semibold', 15, 'bold'), relief=RAISED)
login_label.place(relx=0.05,rely=0.05, relwidth=0.9, relheight=0.2)

login_label2 = Label(login_frame, text="Login as", bg='#76D7C4', fg='black', font=('Open Sans Semibold', 12, 'bold'))
login_label2.place(relx=0.1,rely=0.3, relwidth=0.8, relheight=0.1)

admin_login_button = Button(login_frame,text="ADMIN", bg='white', font=('Open Sans Semibold', 14, 'bold'), fg='black', command=login_admin)
admin_login_button.place(relx=0.15,rely=0.45, relwidth=0.7,relheight=0.2)

patient_login_button = Button(login_frame,text="PATIENT", bg='white', font=('Open Sans Semibold', 14, 'bold'), fg='black')
patient_login_button.place(relx=0.15,rely=0.7, relwidth=0.7,relheight=0.2)

#TODO================================================================================ END
# Commit Changes
conn.commit()
# Close Connection
conn.close()
# Loop GUI
login_window.mainloop()