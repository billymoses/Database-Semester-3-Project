# READ ME
'''
To run this code you should:
1. Install pymsql (pip install pymysql) - to connect to My SQL Database
2. Install pillow (pip install pillow) - to use background picture

To login as admin (run program first):
Username: Admin
Password: Admin
'''

#TODO============================================================================== LIBRARY SECTION
# Library
import pymysql
from tkinter import *
from tkinter import messagebox
from tkinter import ttk
from PIL import Image, ImageTk

#TODO=============================================================================== MYSQL SECTION
# Connect Python to MySQL Database
conn = pymysql.connect(
    host="localhost",
    user="root",
    password="anando2001",
    database="final_project")
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
        if admin_username == "Admin" and admin_password == "Admin":
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
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
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
    patient_title = Label(patient_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
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
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Patient VALUES (%s,%s,%s,%s,%s,%s)", (
                PatientId.get(),
                PatientName.get(),
                PatientGender.get(),
                PatientAge.get(),
                PatientAddress.get(),
                PatientPhone.get()
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_patient():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Patient SET PatientId = %s, PatientName = %s, PatientGender = %s, PatientAge = %s, PatientAddress = %s, PatientPhone = %s WHERE PatientId=%s", (
                PatientId.get(),
                PatientName.get(),
                PatientGender.get(),
                PatientAge.get(),
                PatientAddress.get(),
                PatientPhone.get(),
                PatientId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_patient():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Patient WHERE PatientId=%s", (PatientId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_patient():
        patient_id_entry.delete(0, END)
        patient_name_entry.delete(0, END)
        patient_gender_combo.set("")
        patient_age_entry.delete(0, END)
        patient_address_entry.delete(0, END)
        patient_phone_entry.delete(0, END)

    # Function to close the program
    def exit_patient():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    patient_button_frame = Frame(patient_frame_left, bd=4, relief=RIDGE, bg="white")
    patient_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(patient_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_patient).grid(row=0, column=0, padx=6, pady=3)
    Button(patient_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_patient).grid(row=0, column=1, padx=6, pady=3)
    Button(patient_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_patient).grid(row=1, column=0, padx=6, pady=3)
    Button(patient_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_patient).grid(row=1, column=1, padx=6, pady=3)

    # Patient frame right inside main patient frame
    patient_frame_right = Frame(patient_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    patient_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (patient_frame_right)
    right_title = Label(patient_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    patient_search_combo = ttk.Combobox(patient_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    patient_search_combo['values'] = ("PatientId", "PatientName")
    patient_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    patient_search_entry = Entry(patient_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    patient_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_patient():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Patient WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            patient_display_treeview.delete(*patient_display_treeview.get_children())
            for row in result:
                patient_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    patient_search_button = Button(patient_frame_right, text="SEARCH", width=8, height=2, command=search_patient)
    patient_search_button.grid(row=0, column=3, padx=4, pady=10)

    patient_showall_button = Button(patient_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    patient_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    patient_exit_button = Button(patient_frame_right, text="EXIT", width=8, height=2, command=exit_patient)
    patient_exit_button.grid(row=0, column=5, padx=4, pady=10)

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

# Function Staff Table    
def Staff():
    # Declaration
    StaffId = StringVar()
    StaffName = StringVar()
    StaffGender = StringVar()
    StaffAddress = StringVar()
    StaffPhone = StringVar()
    StaffSalary = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Staff")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Staff_display_treeview.delete(*Staff_display_treeview.get_children())
            for row in result:
                Staff_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Staff_display_treeview.focus()
        Staff_info = Staff_display_treeview.item(view_info)
        row = (Staff_info['values'])
        StaffId.set(row[0])
        StaffName.set(row[1])
        StaffGender.set(row[2])
        StaffAddress.set(row[3])
        StaffPhone.set(row[4])
        StaffSalary.set(row[5])

    # Staff main frame
    Staff_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Staff_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Staff_title = Label(Staff_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Staff_title.pack(side=TOP, fill=X)

    # Staff frame left inside main Staff frame
    Staff_frame_left = Frame(Staff_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Staff_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Staff_frame_left)
    left_title = Label(Staff_frame_left, text="Manage Staff", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Staff_id_label = Label(Staff_frame_left, text="Staff ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_id_label.grid(row=1, column=0, padx=7, pady=10, sticky="W")
    Staff_id_entry = Entry(Staff_frame_left, textvariable=StaffId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")

    Staff_name_label = Label(Staff_frame_left, text="Staff Name:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_name_label.grid(row=2, column=0, padx=7, pady=10, sticky="W")
    Staff_name_entry = Entry(Staff_frame_left, textvariable=StaffName, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_name_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    Staff_gender_label = Label(Staff_frame_left, text="Staff Gender:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_gender_label.grid(row=3, column=0, padx=7, pady=10, sticky="W")
    Staff_gender_combo = ttk.Combobox(Staff_frame_left, textvariable=StaffGender, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Staff_gender_combo['values'] = ("Male", "Female")
    Staff_gender_combo.grid(row=3, column=1, padx=17, pady=10)

    Staff_address_label = Label(Staff_frame_left, text="Staff Address:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_address_label.grid(row=4, column=0, padx=7, pady=10, sticky="W")
    Staff_address_entry = Entry(Staff_frame_left, textvariable=StaffAddress, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_address_entry.grid(row=4, column=1, padx=17, pady=10, sticky="W")

    Staff_phone_label = Label(Staff_frame_left, text="Staff Phone:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_phone_label.grid(row=5, column=0, padx=7, pady=10, sticky="W")
    Staff_phone_entry = Entry(Staff_frame_left, textvariable=StaffPhone, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_phone_entry.grid(row=5, column=1, padx=17, pady=10, sticky="W")

    Staff_salary_label = Label(Staff_frame_left, text="Staff Salary:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_salary_label.grid(row=6, column=0, padx=7, pady=10, sticky="W")
    Staff_salary_entry = Entry(Staff_frame_left, textvariable=StaffSalary, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_salary_entry.grid(row=6, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_Staff():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Staff VALUES (%s,%s,%s,%s,%s,%s)", (
                StaffId.get(),
                StaffName.get(),
                StaffGender.get(),
                StaffAddress.get(),
                StaffPhone.get(),
                StaffSalary.get()
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Staff():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Staff SET StaffId = %s, StaffName = %s, StaffGender = %s, StaffAddress = %s, StaffPhone = %s, StaffSalary = %s WHERE StaffId=%s", (
                StaffId.get(),
                StaffName.get(),
                StaffGender.get(),
                StaffAddress.get(),
                StaffPhone.get(),
                StaffSalary.get(),
                StaffId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Staff():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Staff WHERE StaffId=%s", (StaffId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Staff():
        Staff_id_entry.delete(0, END)
        Staff_name_entry.delete(0, END)
        Staff_gender_combo.set("")
        Staff_address_entry.delete(0, END)
        Staff_phone_entry.delete(0, END)
        Staff_salary_entry.delete(0, END)

    # Function to close the program
    def exit_Staff():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Staff_button_frame = Frame(Staff_frame_left, bd=4, relief=RIDGE, bg="white")
    Staff_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(Staff_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_Staff).grid(row=0, column=0, padx=6, pady=3)
    Button(Staff_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_Staff).grid(row=0, column=1, padx=6, pady=3)
    Button(Staff_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_Staff).grid(row=1, column=0, padx=6, pady=3)
    Button(Staff_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_Staff).grid(row=1, column=1, padx=6, pady=3)

    # Staff frame right inside main Staff frame
    Staff_frame_right = Frame(Staff_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Staff_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Staff_frame_right)
    right_title = Label(Staff_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Staff_search_combo = ttk.Combobox(Staff_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Staff_search_combo['values'] = ("StaffId", "StaffName")
    Staff_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Staff_search_entry = Entry(Staff_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Staff():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Staff WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Staff_display_treeview.delete(*Staff_display_treeview.get_children())
            for row in result:
                Staff_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Staff_search_button = Button(Staff_frame_right, text="SEARCH", width=8, height=2, command=search_Staff)
    Staff_search_button.grid(row=0, column=3, padx=4, pady=10)

    Staff_showall_button = Button(Staff_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Staff_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Staff_exit_button = Button(Staff_frame_right, text="EXIT", width=8, height=2, command=exit_Staff)
    Staff_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Staff_display_frame = Frame(Staff_frame_right, bd=4, relief=RIDGE, bg="white")
    Staff_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Staff_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Staff_display_frame, orient=VERTICAL)
    Staff_display_treeview = ttk.Treeview(Staff_display_frame, columns=("StaffId", "StaffName", "StaffGender", "StaffAddress", "StaffPhone", "StaffSalary"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Staff_display_treeview.xview)
    scroll_y.config(command=Staff_display_treeview.yview)
    Staff_display_treeview.heading("StaffId", text="StaffId")
    Staff_display_treeview.heading("StaffName", text="StaffName")
    Staff_display_treeview.heading("StaffGender", text="StaffGender")
    Staff_display_treeview.heading("StaffAddress", text="StaffAddress")
    Staff_display_treeview.heading("StaffPhone", text="StaffPhone")
    Staff_display_treeview.heading("StaffSalary", text="StaffSalary")
    Staff_display_treeview['show'] = 'headings'
    Staff_display_treeview.column("StaffId", width=100, anchor=CENTER)
    Staff_display_treeview.column("StaffName", width=150, anchor=CENTER)
    Staff_display_treeview.column("StaffGender", width=100, anchor=CENTER)
    Staff_display_treeview.column("StaffAddress", width=150, anchor=CENTER)
    Staff_display_treeview.column("StaffPhone", width=100, anchor=CENTER)
    Staff_display_treeview.column("StaffSalary", width=100, anchor=CENTER)
    Staff_display_treeview.pack(fill=BOTH, expand=1)
    Staff_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()
    
# Function Doctor Table    
def Doctor():
    # Declaration
    DoctorId = StringVar()
    DoctorName = StringVar()
    DoctorGender = StringVar()
    DoctorAddress = StringVar()
    DoctorPhone = StringVar()
    DoctorSalary = StringVar()
    DoctorSpecialist = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Doctor")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Doctor_display_treeview.delete(*Doctor_display_treeview.get_children())
            for row in result:
                Doctor_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Doctor_display_treeview.focus()
        Doctor_info = Doctor_display_treeview.item(view_info)
        row = (Doctor_info['values'])
        DoctorId.set(row[0])
        DoctorName.set(row[1])
        DoctorGender.set(row[2])
        DoctorAddress.set(row[3])
        DoctorPhone.set(row[4])
        DoctorSalary.set(row[5])
        DoctorSpecialist.set(row[6])

    # Doctor main frame
    Doctor_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Doctor_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Doctor_title = Label(Doctor_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Doctor_title.pack(side=TOP, fill=X)

    # Doctor frame left inside main Doctor frame
    Doctor_frame_left = Frame(Doctor_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Doctor_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Doctor_frame_left)
    left_title = Label(Doctor_frame_left, text="Manage Doctor", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Doctor_id_label = Label(Doctor_frame_left, text="Doctor ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_id_label.grid(row=1, column=0, padx=7, pady=10, sticky="W")
    Doctor_id_entry = Entry(Doctor_frame_left, textvariable=DoctorId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")

    Doctor_name_label = Label(Doctor_frame_left, text="Doctor Name:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_name_label.grid(row=2, column=0, padx=7, pady=10, sticky="W")
    Doctor_name_entry = Entry(Doctor_frame_left, textvariable=DoctorName, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_name_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    Doctor_gender_label = Label(Doctor_frame_left, text="Doctor Gender:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_gender_label.grid(row=3, column=0, padx=7, pady=10, sticky="W")
    Doctor_gender_combo = ttk.Combobox(Doctor_frame_left, textvariable=DoctorGender, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Doctor_gender_combo['values'] = ("Male", "Female")
    Doctor_gender_combo.grid(row=3, column=1, padx=17, pady=10)

    Doctor_address_label = Label(Doctor_frame_left, text="Doctor Address:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_address_label.grid(row=4, column=0, padx=7, pady=10, sticky="W")
    Doctor_address_entry = Entry(Doctor_frame_left, textvariable=DoctorAddress, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_address_entry.grid(row=4, column=1, padx=17, pady=10, sticky="W")

    Doctor_phone_label = Label(Doctor_frame_left, text="Doctor Phone:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_phone_label.grid(row=5, column=0, padx=7, pady=10, sticky="W")
    Doctor_phone_entry = Entry(Doctor_frame_left, textvariable=DoctorPhone, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_phone_entry.grid(row=5, column=1, padx=17, pady=10, sticky="W")

    Doctor_salary_label = Label(Doctor_frame_left, text="Doctor Salary:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_salary_label.grid(row=6, column=0, padx=7, pady=10, sticky="W")
    Doctor_salary_entry = Entry(Doctor_frame_left, textvariable=DoctorSalary, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_salary_entry.grid(row=6, column=1, padx=17, pady=10, sticky="W")

    Doctor_specialist_label = Label(Doctor_frame_left, text="Specialist ID", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_specialist_label.grid(row=7, column=0, padx=7, pady=10, sticky="W")
    Doctor_specialist_entry = Entry(Doctor_frame_left, textvariable=DoctorSpecialist, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_specialist_entry.grid(row=7, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_Doctor():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Doctor VALUES (%s,%s,%s,%s,%s,%s,%s)", (
                DoctorId.get(),
                DoctorName.get(),
                DoctorGender.get(),
                DoctorAddress.get(),
                DoctorPhone.get(),
                DoctorSalary.get(),
                DoctorSpecialist.get()
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Doctor():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Doctor SET DoctorId = %s, DoctorName = %s, DoctorGender = %s, DoctorAddress = %s, DoctorPhone = %s, DoctorSalary = %s, SpecialistId = %s WHERE DoctorId=%s", (
                DoctorId.get(),
                DoctorName.get(),
                DoctorGender.get(),
                DoctorAddress.get(),
                DoctorPhone.get(),
                DoctorSalary.get(),
                DoctorSpecialist.get(),
                DoctorId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Doctor():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Doctor WHERE DoctorId=%s", (DoctorId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Doctor():
        Doctor_id_entry.delete(0, END)
        Doctor_name_entry.delete(0, END)
        Doctor_gender_combo.set("")
        Doctor_address_entry.delete(0, END)
        Doctor_phone_entry.delete(0, END)
        Doctor_salary_entry.delete(0, END)
        Doctor_specialist_entry.delete(0, END)

    # Function to close the program
    def exit_Doctor():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Doctor_button_frame = Frame(Doctor_frame_left, bd=4, relief=RIDGE, bg="white")
    Doctor_button_frame.place(x=15, y=480, width=410, height=75)

    # Button inside button frame
    Button(Doctor_button_frame, text="INSERT", font=('open Sans Semibold', 10, 'bold'), width=23, height=1, bg="#76D7C4", command=insert_Doctor).grid(row=0, column=0, padx=4, pady=2)
    Button(Doctor_button_frame, text="UPDATE", font=('open Sans Semibold', 10, 'bold'), width=23, height=1, bg="#76D7C4", command=update_Doctor).grid(row=0, column=1, padx=4, pady=2)
    Button(Doctor_button_frame, text="DELETE", font=('open Sans Semibold', 10, 'bold'), width=23, height=1, bg="#76D7C4", command=delete_Doctor).grid(row=1, column=0, padx=4, pady=2)
    Button(Doctor_button_frame, text="CLEAR", font=('open Sans Semibold', 10, 'bold'), width=23, height=1, bg="#76D7C4", command=clear_Doctor).grid(row=1, column=1, padx=4, pady=2)

    # Doctor frame right inside main Doctor frame
    Doctor_frame_right = Frame(Doctor_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Doctor_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Doctor_frame_right)
    right_title = Label(Doctor_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Doctor_search_combo = ttk.Combobox(Doctor_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Doctor_search_combo['values'] = ("DoctorId", "DoctorName")
    Doctor_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Doctor_search_entry = Entry(Doctor_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Doctor():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Doctor WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Doctor_display_treeview.delete(*Doctor_display_treeview.get_children())
            for row in result:
                Doctor_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Doctor_search_button = Button(Doctor_frame_right, text="SEARCH", width=8, height=2, command=search_Doctor)
    Doctor_search_button.grid(row=0, column=3, padx=4, pady=10)

    Doctor_showall_button = Button(Doctor_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Doctor_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Doctor_exit_button = Button(Doctor_frame_right, text="EXIT", width=8, height=2, command=exit_Doctor)
    Doctor_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Doctor_display_frame = Frame(Doctor_frame_right, bd=4, relief=RIDGE, bg="white")
    Doctor_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Doctor_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Doctor_display_frame, orient=VERTICAL)
    Doctor_display_treeview = ttk.Treeview(Doctor_display_frame, columns=("DoctorId", "DoctorName", "DoctorGender", "DoctorAddress", "DoctorPhone", "DoctorSalary", "DoctorSpecialist"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Doctor_display_treeview.xview)
    scroll_y.config(command=Doctor_display_treeview.yview)
    Doctor_display_treeview.heading("DoctorId", text="DoctorId")
    Doctor_display_treeview.heading("DoctorName", text="DoctorName")
    Doctor_display_treeview.heading("DoctorGender", text="DoctorGender")
    Doctor_display_treeview.heading("DoctorAddress", text="DoctorAddress")
    Doctor_display_treeview.heading("DoctorPhone", text="DoctorPhone")
    Doctor_display_treeview.heading("DoctorSalary", text="DoctorSalary")
    Doctor_display_treeview.heading("DoctorSpecialist", text="SpecialistId")
    Doctor_display_treeview['show'] = 'headings'
    Doctor_display_treeview.column("DoctorId", width=80, anchor=CENTER)
    Doctor_display_treeview.column("DoctorName", width=150, anchor=CENTER)
    Doctor_display_treeview.column("DoctorGender", width=100, anchor=CENTER)
    Doctor_display_treeview.column("DoctorAddress", width=150, anchor=CENTER)
    Doctor_display_treeview.column("DoctorPhone", width=100, anchor=CENTER)
    Doctor_display_treeview.column("DoctorSalary", width=100, anchor=CENTER)
    Doctor_display_treeview.column("DoctorSpecialist", width=100, anchor=CENTER)
    Doctor_display_treeview.pack(fill=BOTH, expand=1)
    Doctor_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()

# Function Transaction Table    
def Transaction():
    # Declaration
    TransactionId = StringVar()
    PatientId = StringVar()
    StaffId = StringVar()
    DoctorId = StringVar()
    TransactionDate = StringVar()
    PaymentType = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Transactions")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Transaction_display_treeview.delete(*Transaction_display_treeview.get_children())
            for row in result:
                Transaction_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Transaction_display_treeview.focus()
        Transaction_info = Transaction_display_treeview.item(view_info)
        row = (Transaction_info['values'])
        TransactionId.set(row[0])
        PatientId.set(row[1])
        StaffId.set(row[2])
        DoctorId.set(row[3])
        TransactionDate.set(row[4])
        PaymentType.set(row[5])

    # Transaction main frame
    Transaction_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Transaction_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Transaction_title = Label(Transaction_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Transaction_title.pack(side=TOP, fill=X)

    # Transaction frame left inside main Transaction frame
    Transaction_frame_left = Frame(Transaction_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Transaction_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Transaction_frame_left)
    left_title = Label(Transaction_frame_left, text="Manage Transaction", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Transaction_id_label = Label(Transaction_frame_left, text="Transaction ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Transaction_id_label.grid(row=1, column=0, padx=7, pady=10, sticky="W")
    Transaction_id_entry = Entry(Transaction_frame_left, textvariable=TransactionId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Transaction_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")

    Patient_id_label = Label(Transaction_frame_left, text="Patient ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Patient_id_label.grid(row=2, column=0, padx=7, pady=10, sticky="W")
    Patient_id_entry = Entry(Transaction_frame_left, textvariable=PatientId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Patient_id_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    Staff_id_label = Label(Transaction_frame_left, text="Staff ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Staff_id_label.grid(row=3, column=0, padx=7, pady=10, sticky="W")
    Staff_id_entry = Entry(Transaction_frame_left, textvariable=StaffId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Staff_id_entry.grid(row=3, column=1, padx=17, pady=10, sticky="W")

    Doctor_id_label = Label(Transaction_frame_left, text="Doctor ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Doctor_id_label.grid(row=4, column=0, padx=7, pady=10, sticky="W")
    Doctor_id_entry = Entry(Transaction_frame_left, textvariable=DoctorId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Doctor_id_entry.grid(row=4, column=1, padx=17, pady=10, sticky="W")

    Transaction_date_label = Label(Transaction_frame_left, text="Transaction Date:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Transaction_date_label.grid(row=5, column=0, padx=0, pady=10, sticky="W")
    Transaction_date_entry = Entry(Transaction_frame_left, textvariable=TransactionDate, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Transaction_date_entry.grid(row=5, column=1, padx=17, pady=10, sticky="W")

    Payment_type_label = Label(Transaction_frame_left, text="Payment Type:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Payment_type_label.grid(row=6, column=0, padx=7, pady=10, sticky="W")
    Payment_type_entry = Entry(Transaction_frame_left, textvariable=PaymentType, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Payment_type_entry.grid(row=6, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_Transaction():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Transactions VALUES (%s,%s,%s,%s,%s,%s)", (
                TransactionId.get(),
                PatientId.get(),
                StaffId.get(),
                DoctorId.get(),
                TransactionDate.get(),
                PaymentType.get()
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Transaction():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Transactions SET TransactionId = %s, PatientId = %s, StaffId = %s, DoctorId = %s, TransactionDate = %s, PaymentType = %s WHERE TransactionId=%s", (
                TransactionId.get(),
                PatientId.get(),
                StaffId.get(),
                DoctorId.get(),
                TransactionDate.get(),
                PaymentType.get(),
                TransactionId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Transaction():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Transactions WHERE TransactionId=%s", (TransactionId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Transaction():
        Transaction_id_entry.delete(0, END)
        Patient_id_entry.delete(0, END)
        Staff_id_entry.delete(0, END)
        Doctor_id_entry.delete(0, END)
        Transaction_date_entry.delete(0, END)
        Payment_type_entry.delete(0, END)

    # Function to close the program
    def exit_Transaction():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Transaction_button_frame = Frame(Transaction_frame_left, bd=4, relief=RIDGE, bg="white")
    Transaction_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(Transaction_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_Transaction).grid(row=0, column=0, padx=6, pady=3)
    Button(Transaction_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_Transaction).grid(row=0, column=1, padx=6, pady=3)
    Button(Transaction_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_Transaction).grid(row=1, column=0, padx=6, pady=3)
    Button(Transaction_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_Transaction).grid(row=1, column=1, padx=6, pady=3)

    # Transaction frame right inside main Transaction frame
    Transaction_frame_right = Frame(Transaction_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Transaction_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Transaction_frame_right)
    right_title = Label(Transaction_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Transaction_search_combo = ttk.Combobox(Transaction_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Transaction_search_combo['values'] = ("TransactionId", "PatientId", "StaffId", "DoctorId", "PaymentType")
    Transaction_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Transaction_search_entry = Entry(Transaction_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Transaction_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Transaction():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Transactions WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Transaction_display_treeview.delete(*Transaction_display_treeview.get_children())
            for row in result:
                Transaction_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Transaction_search_button = Button(Transaction_frame_right, text="SEARCH", width=8, height=2, command=search_Transaction)
    Transaction_search_button.grid(row=0, column=3, padx=4, pady=10)

    Transaction_showall_button = Button(Transaction_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Transaction_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Transaction_exit_button = Button(Transaction_frame_right, text="EXIT", width=8, height=2, command=exit_Transaction)
    Transaction_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Transaction_display_frame = Frame(Transaction_frame_right, bd=4, relief=RIDGE, bg="white")
    Transaction_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Transaction_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Transaction_display_frame, orient=VERTICAL)
    Transaction_display_treeview = ttk.Treeview(Transaction_display_frame, columns=("TransactionId", "PatientId", "StaffId", "DoctorId", "TransactionDate", "PaymentType"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Transaction_display_treeview.xview)
    scroll_y.config(command=Transaction_display_treeview.yview)
    Transaction_display_treeview.heading("TransactionId", text="TransactionId")
    Transaction_display_treeview.heading("PatientId", text="PatientId")
    Transaction_display_treeview.heading("StaffId", text="StaffId")
    Transaction_display_treeview.heading("DoctorId", text="DoctorId")
    Transaction_display_treeview.heading("TransactionDate", text="TransactionDate")
    Transaction_display_treeview.heading("PaymentType", text="PaymentType")
    Transaction_display_treeview['show'] = 'headings'
    Transaction_display_treeview.column("TransactionId", width=100, anchor=CENTER)
    Transaction_display_treeview.column("PatientId", width=100, anchor=CENTER)
    Transaction_display_treeview.column("StaffId", width=100, anchor=CENTER)
    Transaction_display_treeview.column("DoctorId", width=100, anchor=CENTER)
    Transaction_display_treeview.column("TransactionDate", width=100, anchor=CENTER)
    Transaction_display_treeview.column("PaymentType", width=100, anchor=CENTER)
    Transaction_display_treeview.pack(fill=BOTH, expand=1)
    Transaction_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()

# Function Treatment Table    
def Treatment():
    # Declaration
    TreatmentId = StringVar()
    TreatmentName = StringVar()
    TreatmentPrice = StringVar()
    TreatmentTypeId = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Treatment")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Treatment_display_treeview.delete(*Treatment_display_treeview.get_children())
            for row in result:
                Treatment_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Treatment_display_treeview.focus()
        Treatment_info = Treatment_display_treeview.item(view_info)
        row = (Treatment_info['values'])
        TreatmentId.set(row[0])
        TreatmentName.set(row[1])
        TreatmentPrice.set(row[2])
        TreatmentTypeId.set(row[3])

    # Treatment main frame
    Treatment_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Treatment_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Treatment_title = Label(Treatment_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Treatment_title.pack(side=TOP, fill=X)

    # Treatment frame left inside main Treatment frame
    Treatment_frame_left = Frame(Treatment_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Treatment_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Treatment_frame_left)
    left_title = Label(Treatment_frame_left, text="Manage Treatment", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Treatment_id_label = Label(Treatment_frame_left, text="Treatment ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Treatment_id_label.grid(row=1, column=0, padx=5, pady=10, sticky="W")
    Treatment_id_entry = Entry(Treatment_frame_left, textvariable=TreatmentId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Treatment_id_entry.grid(row=1, column=1, padx=5, pady=10, sticky="W")

    Treatment_name_label = Label(Treatment_frame_left, text="Treatment Name:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Treatment_name_label.grid(row=2, column=0, padx=5, pady=10, sticky="W")
    Treatment_name_entry = Entry(Treatment_frame_left, textvariable=TreatmentName, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Treatment_name_entry.grid(row=2, column=1, padx=5, pady=10, sticky="W")

    Treatment_price_label = Label(Treatment_frame_left, text="Treatment Price:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Treatment_price_label.grid(row=3, column=0, padx=5, pady=10, sticky="W")
    Treatment_price_entry = Entry(Treatment_frame_left, textvariable=TreatmentPrice, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Treatment_price_entry.grid(row=3, column=1, padx=5, pady=10, sticky="W")

    Treatment_type_id_label = Label(Treatment_frame_left, text="TreatmentType ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Treatment_type_id_label.grid(row=4, column=0, padx=5, pady=10, sticky="W")
    Treatment_type_id_entry = Entry(Treatment_frame_left, textvariable=TreatmentTypeId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Treatment_type_id_entry.grid(row=4, column=1, padx=5, pady=10, sticky="W")

    # Insert data to database
    def insert_Treatment():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Treatment VALUES (%s,%s,%s,%s)", (
                TreatmentId.get(),
                TreatmentName.get(),
                TreatmentPrice.get(),
                TreatmentTypeId.get(),
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Treatment():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Treatment SET TreatmentId = %s, TreatmentName = %s, TreatmentPrice = %s, TreatmentTypeId = %s WHERE TreatmentId=%s", (
                TreatmentId.get(),
                TreatmentName.get(),
                TreatmentPrice.get(),
                TreatmentTypeId.get(),
                TreatmentId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Treatment():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Treatment WHERE TreatmentId=%s", (TreatmentId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Treatment():
        Treatment_id_entry.delete(0, END)
        Treatment_name_entry.delete(0, END)
        Treatment_price_entry.delete(0, END)
        Treatment_type_id_entry.delete(0, END)

    # Function to close the program
    def exit_Treatment():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Treatment_button_frame = Frame(Treatment_frame_left, bd=4, relief=RIDGE, bg="white")
    Treatment_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(Treatment_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_Treatment).grid(row=0, column=0, padx=6, pady=3)
    Button(Treatment_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_Treatment).grid(row=0, column=1, padx=6, pady=3)
    Button(Treatment_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_Treatment).grid(row=1, column=0, padx=6, pady=3)
    Button(Treatment_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_Treatment).grid(row=1, column=1, padx=6, pady=3)

    # Treatment frame right inside main Treatment frame
    Treatment_frame_right = Frame(Treatment_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Treatment_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Treatment_frame_right)
    right_title = Label(Treatment_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Treatment_search_combo = ttk.Combobox(Treatment_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Treatment_search_combo['values'] = ("TreatmentId", "TreatmentName")
    Treatment_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Treatment_search_entry = Entry(Treatment_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Treatment_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Treatment():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Treatment WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Treatment_display_treeview.delete(*Treatment_display_treeview.get_children())
            for row in result:
                Treatment_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Treatment_search_button = Button(Treatment_frame_right, text="SEARCH", width=8, height=2, command=search_Treatment)
    Treatment_search_button.grid(row=0, column=3, padx=4, pady=10)

    Treatment_showall_button = Button(Treatment_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Treatment_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Treatment_exit_button = Button(Treatment_frame_right, text="EXIT", width=8, height=2, command=exit_Treatment)
    Treatment_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Treatment_display_frame = Frame(Treatment_frame_right, bd=4, relief=RIDGE, bg="white")
    Treatment_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Treatment_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Treatment_display_frame, orient=VERTICAL)
    Treatment_display_treeview = ttk.Treeview(Treatment_display_frame, columns=("TreatmentId", "TreatmentName", "TreatmentPrice", "TreatmentTypeId"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Treatment_display_treeview.xview)
    scroll_y.config(command=Treatment_display_treeview.yview)
    Treatment_display_treeview.heading("TreatmentId", text="TreatmentId")
    Treatment_display_treeview.heading("TreatmentName", text="TreatmentName")
    Treatment_display_treeview.heading("TreatmentPrice", text="TreatmentPrice")
    Treatment_display_treeview.heading("TreatmentTypeId", text="TreatmentTypeId")
    Treatment_display_treeview['show'] = 'headings'
    Treatment_display_treeview.column("TreatmentId", width=80, anchor=CENTER)
    Treatment_display_treeview.column("TreatmentName", width=100, anchor=CENTER)
    Treatment_display_treeview.column("TreatmentPrice", width=100, anchor=CENTER)
    Treatment_display_treeview.column("TreatmentTypeId", width=80, anchor=CENTER)
    Treatment_display_treeview.pack(fill=BOTH, expand=1)
    Treatment_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()

# Function Schedule Table    
def Schedule():
    # Declaration
    ScheduleId = StringVar()
    TransactionId = StringVar()
    ShiftId = StringVar()
    ScheduleDate = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Schedule")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Schedule_display_treeview.delete(*Schedule_display_treeview.get_children())
            for row in result:
                Schedule_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Schedule_display_treeview.focus()
        Schedule_info = Schedule_display_treeview.item(view_info)
        row = (Schedule_info['values'])
        ScheduleId.set(row[0])
        TransactionId.set(row[1])
        ShiftId.set(row[2])
        ScheduleDate.set(row[3])

    # Schedule main frame
    Schedule_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Schedule_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Schedule_title = Label(Schedule_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Schedule_title.pack(side=TOP, fill=X)

    # Schedule frame left inside main Schedule frame
    Schedule_frame_left = Frame(Schedule_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Schedule_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Schedule_frame_left)
    left_title = Label(Schedule_frame_left, text="Manage Schedule", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Schedule_id_label = Label(Schedule_frame_left, text="Schedule ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Schedule_id_label.grid(row=1, column=0, padx=9, pady=10, sticky="W")
    Schedule_id_entry = Entry(Schedule_frame_left, textvariable=ScheduleId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Schedule_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")

    Transaction_id_label = Label(Schedule_frame_left, text="Transaction ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Transaction_id_label.grid(row=2, column=0, padx=9, pady=10, sticky="W")
    Transaction_id_entry = Entry(Schedule_frame_left, textvariable=TransactionId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Transaction_id_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    Shift_id_label = Label(Schedule_frame_left, text="Shift ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Shift_id_label.grid(row=3, column=0, padx=9, pady=10, sticky="W")
    Shift_id_entry = Entry(Schedule_frame_left, textvariable=ShiftId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Shift_id_entry.grid(row=3, column=1, padx=17, pady=10, sticky="W")

    Schedule_date_label = Label(Schedule_frame_left, text="Schedule Date:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Schedule_date_label.grid(row=4, column=0, padx=9, pady=10, sticky="W")
    Schedule_date_entry = Entry(Schedule_frame_left, textvariable=ScheduleDate, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Schedule_date_entry.grid(row=4, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_Schedule():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Schedule VALUES (%s,%s,%s,%s)", (
                ScheduleId.get(),
                TransactionId.get(),
                ShiftId.get(),
                ScheduleDate.get(),
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Schedule():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Schedule SET ScheduleId = %s, TransactionId = %s, ShiftId = %s, ScheduleDate = %s WHERE ScheduleId=%s", (
                ScheduleId.get(),
                TransactionId.get(),
                ShiftId.get(),
                ScheduleDate.get(),
                ScheduleId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Schedule():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Schedule WHERE ScheduleId=%s", (ScheduleId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Schedule():
        Schedule_id_entry.delete(0, END)
        Transaction_id_entry.delete(0, END)
        Shift_id_entry.delete(0, END)
        Schedule_date_entry.delete(0, END)

    # Function to close the program
    def exit_Schedule():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Schedule_button_frame = Frame(Schedule_frame_left, bd=4, relief=RIDGE, bg="white")
    Schedule_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(Schedule_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_Schedule).grid(row=0, column=0, padx=6, pady=3)
    Button(Schedule_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_Schedule).grid(row=0, column=1, padx=6, pady=3)
    Button(Schedule_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_Schedule).grid(row=1, column=0, padx=6, pady=3)
    Button(Schedule_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_Schedule).grid(row=1, column=1, padx=6, pady=3)

    # Schedule frame right inside main Schedule frame
    Schedule_frame_right = Frame(Schedule_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Schedule_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Schedule_frame_right)
    right_title = Label(Schedule_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Schedule_search_combo = ttk.Combobox(Schedule_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Schedule_search_combo['values'] = ("ScheduleId", "TransactionId", "ShiftId")
    Schedule_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Schedule_search_entry = Entry(Schedule_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Schedule_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Schedule():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Schedule WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Schedule_display_treeview.delete(*Schedule_display_treeview.get_children())
            for row in result:
                Schedule_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Schedule_search_button = Button(Schedule_frame_right, text="SEARCH", width=8, height=2, command=search_Schedule)
    Schedule_search_button.grid(row=0, column=3, padx=4, pady=10)

    Schedule_showall_button = Button(Schedule_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Schedule_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Schedule_exit_button = Button(Schedule_frame_right, text="EXIT", width=8, height=2, command=exit_Schedule)
    Schedule_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Schedule_display_frame = Frame(Schedule_frame_right, bd=4, relief=RIDGE, bg="white")
    Schedule_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Schedule_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Schedule_display_frame, orient=VERTICAL)
    Schedule_display_treeview = ttk.Treeview(Schedule_display_frame, columns=("ScheduleId", "TransactionId", "ShiftId", "ScheduleDate"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Schedule_display_treeview.xview)
    scroll_y.config(command=Schedule_display_treeview.yview)
    Schedule_display_treeview.heading("ScheduleId", text="ScheduleId")
    Schedule_display_treeview.heading("TransactionId", text="TransactionId")
    Schedule_display_treeview.heading("ShiftId", text="ShiftId")
    Schedule_display_treeview.heading("ScheduleDate", text="ScheduleDate")
    Schedule_display_treeview['show'] = 'headings'
    Schedule_display_treeview.column("ScheduleId", width=80, anchor=CENTER)
    Schedule_display_treeview.column("TransactionId", width=100, anchor=CENTER)
    Schedule_display_treeview.column("ShiftId", width=100, anchor=CENTER)
    Schedule_display_treeview.column("ScheduleDate", width=80, anchor=CENTER)
    Schedule_display_treeview.pack(fill=BOTH, expand=1)
    Schedule_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()
    
# Function Tracing Table    
def Tracing():
    # Declaration
    PatientId = StringVar()
    RelatedName = StringVar()
    RelatedPhone = StringVar()
    SearchBy = StringVar()
    SearchTxt = StringVar()

    # Display data from database
    def display_data():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Tracing")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Tracing_display_treeview.delete(*Tracing_display_treeview.get_children())
            for row in result:
                Tracing_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()
        
    def calling_back(ev):
        view_info = Tracing_display_treeview.focus()
        Tracing_info = Tracing_display_treeview.item(view_info)
        row = (Tracing_info['values'])
        PatientId.set(row[0])
        RelatedName.set(row[1])
        RelatedPhone.set(row[2])

    # Tracing main frame
    Tracing_frame = Frame(admin_menu_window, relief=SUNKEN, bg="white")
    Tracing_frame.place(x=0, y=0, width=1400, height=750)

    # Heading title label
    Tracing_title = Label(Tracing_frame, text="Hospital Management System", bd=10, relief=GROOVE, font=('open Sans Semibold', 39, 'bold'), bg="#76D7C4")
    Tracing_title.pack(side=TOP, fill=X)

    # Tracing frame left inside main Tracing frame
    Tracing_frame_left = Frame(Tracing_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Tracing_frame_left.place(x=20, y=100, width=450, height=580)

    # Label & Entry box (Tracing_frame_left)
    left_title = Label(Tracing_frame_left, text="Manage Tracing", font=('open Sans Semibold', 30, 'bold'), bg="#76D7C4")
    left_title.grid(row=0, columnspan=2, pady=20)

    Patient_id_label = Label(Tracing_frame_left, text="Patient ID:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Patient_id_label.grid(row=1, column=0, padx=9, pady=10, sticky="W")
    Patient_id_entry = Entry(Tracing_frame_left, textvariable=PatientId, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Patient_id_entry.grid(row=1, column=1, padx=17, pady=10, sticky="W")

    Related_name_label = Label(Tracing_frame_left, text="Related Name:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Related_name_label.grid(row=2, column=0, padx=9, pady=10, sticky="W")
    Related_name_entry = Entry(Tracing_frame_left, textvariable=RelatedName, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Related_name_entry.grid(row=2, column=1, padx=17, pady=10, sticky="W")

    Related_phone_label = Label(Tracing_frame_left, text="Related Phone:", font=('open Sans Semibold', 15, 'bold'), bg="#76D7C4")
    Related_phone_label.grid(row=3, column=0, padx=9, pady=10, sticky="W")
    Related_phone_entry = Entry(Tracing_frame_left, textvariable=RelatedPhone, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Related_phone_entry.grid(row=3, column=1, padx=17, pady=10, sticky="W")

    # Insert data to database
    def insert_Tracing():
        # Confirm
        insert_permission = messagebox.askyesno("Hospital", "Confirm if you want to insert data")
        if insert_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("INSERT INTO Tracing VALUES (%s,%s,%s)", (
                PatientId.get(),
                RelatedName.get(),
                RelatedPhone.get()
            ))

            # Close DB
            conn.commit()
            display_data()

            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully inserted to the database!")
        else: 
            return

    # Function to delete data in database
    def update_Tracing():
        # Confirm
        update_permission = messagebox.askyesno("Hospital", "Confirm if you want to change data")
        if update_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            # Operation
            my_cursor.execute("UPDATE Tracing SET PatientId = %s, RelatedName = %s, RelatedPhone = %s WHERE PatientId=%s", (
                PatientId.get(),
                RelatedName.get(),
                RelatedPhone.get(),
                PatientId.get()
            ))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully updated!")
        else: 
            return

    def delete_Tracing():
        delete_permission = messagebox.askyesno("Hospital", "Confirm if you want to delete data")
        if delete_permission > 0:
            # Open DB
            conn = pymysql.connect(
                host="localhost",
                user="root",
                password="anando2001",
                database="final_project"
            )
            my_cursor = conn.cursor()

            my_cursor.execute("DELETE FROM Tracing WHERE PatientId=%s", (PatientId.get()))

            # Close DB
            conn.commit()
            display_data()
            conn.close()

            # Notification
            messagebox.showinfo("Hospital", "Data succesfully deleted!")
        else:
            return

    # Function to clear entry box
    def clear_Tracing():
        Patient_id_entry.delete(0, END)
        Related_name_entry.delete(0, END)
        Related_phone_entry.delete(0, END)

    # Function to close the program
    def exit_Tracing():
        exit = messagebox.askyesno("Hospital", "Confirm if you want to exit")
        if exit > 0:
            admin_menu_window.destroy()
        return

    # Button main frame
    Tracing_button_frame = Frame(Tracing_frame_left, bd=4, relief=RIDGE, bg="white")
    Tracing_button_frame.place(x=15, y=430, width=410, height=125)

    # Button inside button frame
    Button(Tracing_button_frame, text="INSERT", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=insert_Tracing).grid(row=0, column=0, padx=6, pady=3)
    Button(Tracing_button_frame, text="UPDATE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=update_Tracing).grid(row=0, column=1, padx=6, pady=3)
    Button(Tracing_button_frame, text="DELETE", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=delete_Tracing).grid(row=1, column=0, padx=6, pady=3)
    Button(Tracing_button_frame, text="CLEAR", font=('open Sans Semibold', 12, 'bold'), width=18, height=2, bg="#76D7C4", command=clear_Tracing).grid(row=1, column=1, padx=6, pady=3)

    # Tracing frame right inside main Tracing frame
    Tracing_frame_right = Frame(Tracing_frame, bd=4, relief=RIDGE, bg="#76D7C4")
    Tracing_frame_right.place(x=500, y=100, width=830, height=580)

    # Search box & display box (Tracing_frame_right)
    right_title = Label(Tracing_frame_right, text="Search by", bg="#76D7C4", font=('open Sans Semibold', 15, 'bold'))
    right_title.grid(row=0, column=0, padx=5, pady=10, sticky="W")

    Tracing_search_combo = ttk.Combobox(Tracing_frame_right, textvariable=SearchBy, font=('open Sans Semibold', 15, 'bold'), state='readonly')
    Tracing_search_combo['values'] = ("PatientId", "RelatedName")
    Tracing_search_combo.grid(row=0, column=1, padx=2, pady=10)
    
    Tracing_search_entry = Entry(Tracing_frame_right, textvariable=SearchTxt, font=('open Sans Semibold', 15, 'bold'), bd=5, relief=SUNKEN)
    Tracing_search_entry.grid(row=0, column=2, padx=5, pady=10, sticky="W")

    # Function to search data
    def search_Tracing():
        # Open DB
        conn = pymysql.connect(
            host="localhost",
            user="root",
            password="anando2001",
            database="final_project"
        )
        my_cursor = conn.cursor()
        
        # Operation
        my_cursor.execute("SELECT * FROM Tracing WHERE "+str(SearchBy.get())+" LIKE '%"+str(SearchTxt.get())+"%'")
        result=my_cursor.fetchall()
        if len(result)!=0:
            Tracing_display_treeview.delete(*Tracing_display_treeview.get_children())
            for row in result:
                Tracing_display_treeview.insert('', END, values=row)
                conn.commit()
        conn.close()

    Tracing_search_button = Button(Tracing_frame_right, text="SEARCH", width=8, height=2, command=search_Tracing)
    Tracing_search_button.grid(row=0, column=3, padx=4, pady=10)

    Tracing_showall_button = Button(Tracing_frame_right, text="SHOW ALL", width=8, height=2, command=display_data)
    Tracing_showall_button.grid(row=0, column=4, padx=4, pady=10)
    
    Tracing_exit_button = Button(Tracing_frame_right, text="EXIT", width=8, height=2, command=exit_Tracing)
    Tracing_exit_button.grid(row=0, column=5, padx=4, pady=10)

    # Display frame
    Tracing_display_frame = Frame(Tracing_frame_right, bd=4, relief=RIDGE, bg="white")
    Tracing_display_frame.place(x=10, y=70, width=790, height=500)

    #Scroll bar & Treeview
    scroll_x = Scrollbar(Tracing_display_frame, orient=HORIZONTAL)
    scroll_y = Scrollbar(Tracing_display_frame, orient=VERTICAL)
    Tracing_display_treeview = ttk.Treeview(Tracing_display_frame, columns=("PatientId", "RelatedName", "RelatedPhone"), xscrollcommand=scroll_x.set, yscrollcommand=scroll_y.set)
    scroll_x.pack(side=BOTTOM, fill=X)
    scroll_y.pack(side=RIGHT, fill=Y)
    scroll_x.config(command=Tracing_display_treeview.xview)
    scroll_y.config(command=Tracing_display_treeview.yview)
    Tracing_display_treeview.heading("PatientId", text="PatientId")
    Tracing_display_treeview.heading("RelatedName", text="RelatedName")
    Tracing_display_treeview.heading("RelatedPhone", text="RelatedPhone")
    Tracing_display_treeview['show'] = 'headings'
    Tracing_display_treeview.column("PatientId", width=80, anchor=CENTER)
    Tracing_display_treeview.column("RelatedName", width=100, anchor=CENTER)
    Tracing_display_treeview.column("RelatedPhone", width=100, anchor=CENTER)
    Tracing_display_treeview.pack(fill=BOTH, expand=1)
    Tracing_display_treeview.bind("<ButtonRelease-1>", calling_back)
    display_data()
    
# Function Menu Admin
def admin_menu():
    login_admin_window.destroy()
    global admin_menu_window
    admin_menu_window = Tk()
    admin_menu_window.title("SANDYAGA Hospital")
    admin_menu_window.geometry("1350x750")

    # Declare menu
    my_menu = Menu(admin_menu_window)
    admin_menu_window.config(menu = my_menu)

    # Creating menu bars
    open_menu = Menu(my_menu)
    my_menu.add_cascade(label="Table", menu=open_menu)
    open_menu.add_command(label="Patient", command=Patient)
    open_menu.add_command(label="Staff", command=Staff)
    open_menu.add_command(label="Doctor", command=Doctor)
    open_menu.add_command(label="Transaction", command=Transaction)
    open_menu.add_command(label="Treatment", command=Treatment)
    open_menu.add_command(label="Schedule", command=Schedule)
    open_menu.add_command(label="Tracing", command=Tracing)

    # Default Display
    Patient()
    # Loop GUI 
    admin_menu_window.mainloop()
    
#TODO================================================================================ LOGIN SECTION
# Creating the main window
login_window = Tk()
login_window.title("SANDYAGA Hospital")
login_window.minsize(width=625,height=418)
login_window.maxsize(width=625,height=418)
login_window.geometry("625x418")

# Adding a background image
background_image =ImageTk.PhotoImage(Image.open("BackgroundPic.jpg"))
background_label = Label(image=background_image)
background_label.pack()

# Login frame
login_frame = Frame(login_window, bg="#76D7C4", bd=4, relief=RIDGE)
login_frame.place(relx=0.55,rely=0.17,relwidth=0.4,relheight=0.7)

# Login label
login_label = Label(login_frame, text="SANDYAGA\nHOSPITAL", bg='white', fg='black', font=('Open Sans Semibold', 19, 'bold'), relief=RAISED)
login_label.place(relx=0.05,rely=0.04, relwidth=0.9, relheight=0.3)

login_label2 = Label(login_frame, text="Welcome to our database system!", bg='#76D7C4', fg='black', font=('Open Sans Semibold', 10, 'bold'))
login_label2.place(relx=0.05,rely=0.35, relwidth=0.9, relheight=0.2)

admin_login_button = Button(login_frame,text="LOGIN ", bg='white', font=('Open Sans Semibold', 14, 'bold'), fg='black', command=login_admin)
admin_login_button.place(relx=0.25,rely=0.57, relwidth=0.5,relheight=0.2)

login_label3 = Label(login_frame, text="Copyright @SANDYAGA", bg='#76D7C4', fg='black', font=('Open Sans Semibold', 8, 'bold'))
login_label3.place(relx=0.43,rely=0.91, relwidth=0.55, relheight=0.07)

#TODO================================================================================ END
# Commit Changes
conn.commit()
# Close Connection
conn.close()
# Loop GUI
login_window.mainloop()