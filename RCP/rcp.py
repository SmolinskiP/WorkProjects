from tkinter import *
import mysql.connector as database
import sys
from datetime import datetime
import time
import os
from tkinter import font as fnt
from time import sleep
import logging

success_check = "0"
card_id = sys.argv[1]
print(card_id)
# Connect to MariaDB LOCAL
try:
    conn = database.connect(
        user="rcp",
        password="tajnehaslo",
        host="localhost",
        database="RFID"
    )
except database.Error as e:
    print(f"Nie udalo sie polaczyc z baza danych MariaDB: {e}")
    sys.exit(1)

cursor = conn.cursor()

# Zapytanie SQL przypisujace karte do pracownika
cursor.execute("SELECT id FROM pracownicy WHERE karta='%s'" % card_id)
employee_id = cursor.fetchall()
print(employee_id)
if not employee_id:
#	print("Nie rozpoznano karty RFID")
#	success_check = "1"
#	os.system("python3 /etc/rcp/readrs.py " + str(success_check))
#	error = Tk()
#	error.title("Wpis istnieje - nie kontynuje dzialania")
#	error.overrideredirect(True)
#	error.overrideredirect(False)
#	error.attributes('-fullscreen',True)
#	error_window = Label(error, text="ERROR:\nBrak karty w systemie", fg='red', font=(None, 28, 'bold',))
#       error_window.place(x=250, y=150, anchor="center")
#       error.after(3000, lambda: error.destroy())
	root3 = Tk()
	root3.title("Rejestrator czasu w firmie")

# Set window on full screen
	root3.overrideredirect(True)
	root3.overrideredirect(False)
	root3.attributes('-fullscreen',True)
#	enter_btn = Button(root3, text="Wejscie", width=12, height=4, font = fnt.Font(size = 21), bg="green", activebackground="#006400", command= lambda: check_entry(employee_id, 1))
#	enter_btn.grid(row=1, column=0)
	root3_window = Label(root3, text="ERROR:\nNie znaleziono\nkarty w systemie", fg='red', font=(None, 25, 'bold'))
	root3_window.place(x=250, y=150, anchor="center")
	root3.after(3000, lambda: root3.destroy())
	root3.mainloop()
else:
	employee_id = employee_id[0]
	employee_id = employee_id[0]

# Functions definitions
def check_work(action_type):
        time_of_entry = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        cursor.execute("INSERT INTO obecnosc (pracownik, action) VALUES (%s, %s)", (employee_id, action_type))
        conn.commit()
        try:
            conn2 = database.connect(
            user="rcp",
            password="rcp",
            host="x.x.x.x",
            database="RFID"
            )
            file_object = open('/etc/rcp/log/connectlog.txt', 'a')
            file_object.write(time_of_entry + " - Udalo sie połączyć z bazą 10.0.10.1 z paramtrami: ID - " + str(employee_id) + " Akcja - " + str(action_type) + "\n")
            file_object.close()
        except database.Error as e:
            print(f"Nie udalo sie polaczyc z baza danych MariaDB: {e}")
            file_object = open('/etc/rcp/log/connectlog.txt', 'a')
            file_object.write(f"Nie udalo sie polaczyc z baza danych MariaDB: {e}\n")
            file_object.close()
            sys.exit(1)
        cursor2 = conn2.cursor()
        cursor2.execute("INSERT INTO obecnosc (pracownik, action) VALUES (%s, %s)", (employee_id, action_type))
        conn2.commit()
        actual_time = datetime.today().strftime('%Y-%m-%d')
        actual_hour = datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        try:
            sql_zapytanko = "SELECT id FROM obecnosc WHERE action = " + str(action_type) + " AND pracownik = " + str(employee_id) + " AND time LIKE '" + actual_time + "%'"
            cursor2.execute(sql_zapytanko)
            result2 = cursor2.fetchall()
            if not result2:
                file_object = open('/etc/rcp/accesslog.txt', 'a')
                file_object.write("Akcja: " + str(action_type) + " Pracownik: " + str(employee_id) + "Czas: " + actual_time + "\n")
                file_object.close()
        except:
            file_object = open('/etc/rcp/log/errorlog.txt', 'a')
            file_object.write(actual_hour + "Krytyczny blad\n")
            file_object.close()


#        try:
#            sql_zapytanko = "SELECT id FROM obecnosc WHERE action='%s' AND pracownik='%s' AND time LIKE '%s'%" % (action, employee_id, actual_time)
#            cursor2.execute(sql_zapytanko)
#            file_object = open('/etc/rcp/log.txt', 'a')
#            file_object.write(sql_zapytanko)
#            file_object.close()
#        except database.Error as e:
#            file_object = open('/etc/rcp/log.txt', 'a')
#            file_object.write(f"Taki blad: {e}")
#            file_object.close()
#        result2 = cursor2.fetchall()
#        if not result2:
#            file_object = open('/etc/rcp/log.txt', 'w')
#            file_object.write(employee_id + " " + actual_hour + " " + str(action_type))
#            file_object.close()

def check_entry(employee_id, action_type):
	cursor.execute("SELECT pracownik, action, time FROM obecnosc")
	query = cursor.fetchall()
	now = datetime.now()
	check_date = now.strftime("%Y-%m-%d")
	cursor.execute("SELECT pracownik, action, time FROM obecnosc WHERE pracownik = " + str(employee_id) + " AND action = 1 AND time LIKE \'" + str(check_date) + "%\'")
	query2 = cursor.fetchall()
	var = 0
	check_entry = 0
	for (pracownik, action, time) in query:
		test_var = 0
#ZAKAZ WYCHODZENIA PRZED WCHODZENIEM
#		now = datetime.now()
#		check_date = now.strftime("%Y-%m-%d")
#		cursor.execute("SELECT pracownik, action, time FROM obecnosc WHERE pracownik = " + str(employee_id) + " AND action = 1 AND time LIKE \'" + str(check_date) + "%\'")
#		query2 = cursor.fetchall()
#		print(type(query2))
		if not query2 and (action_type == 2 or action_type == 3 or action_type == 4):
			var += 1
			test_var = 5
#KONIEC ZAKAZU
		time = str(time)
		time = time[0:10]
		now = datetime.now()
		localtime = now.strftime("%Y-%m-%d")
#		print(action_type)
#		print(action)
		check_condition = 0
		if pracownik == employee_id and time == localtime and action == 1:
			check_condition += 1
		if pracownik == employee_id and action_type == action and time == localtime:
			print("wpis istnieje")
			var += 1

	if var == 0:
                success_check = "2"
                check_work(action_type)
                actual_time = datetime.today().strftime('%Y-%m-%d')
                sleep(0.11)
                cursor.execute("SELECT id FROM obecnosc WHERE action='%s' AND pracownik='%s' AND time > '%s'" % (action, employee_id, actual_time))
                sleep(0.11)
                result = cursor.fetchall()
                if not result:
                        success = Tk()
                        success.title("Wpis istnieje - nie kontynuje dzialania")
                        success.overrideredirect(True)
                        success.overrideredirect(False)
                        success.attributes('-fullscreen',True)
                        success_window = Label(success, text="ERROR:\nNieznany błąd\nSpróbuj ponownie", fg='red',font=(None, 25, 'bold'))
                        success_window.place(x=250, y=150, anchor="center")
                        success.after(3000, lambda: success.destroy())

                else:
                        success = Tk()
                        success.title("Wpis istnieje - nie kontynuje dzialania")
                        success.overrideredirect(True)
                        success.overrideredirect(False)
                        success.attributes('-fullscreen',True)
                        success_window = Label(success, text="SUKCES:\nPomyslnie\nzarejestrowano wpis", fg='green', font=(None, 25, 'bold'))
                        success_window.place(x=250, y=150, anchor="center")
                        success.after(3000, lambda: success.destroy())
                        del result
#                success_check = "2"
	else:
                error = Tk()
                error.title("Wpis istnieje - nie kontynuje dzialania")
                error.overrideredirect(True)
                error.overrideredirect(False)
                error.attributes('-fullscreen',True)
                if action_type == 1:
                        error_window = Label(error, text="ERROR:\nJuż odnotowano\ndzisiejsze logowanie", fg='red', font=(None, 28, 'bold',))
                elif action_type == 2 and test_var == 5:
                        error_window = Label(error, text="ERROR:\nŻeby wyjść z pracy,\nnajpierw do niej wejdź ;)", fg='red', font=(None, 28, 'bold'))
                elif action_type == 3 and test_var == 5:
                        error_window = Label(error, text="ERROR:\nŻeby iść na przerwę,\nnajpierw wejdź do pracy ;)", fg='red', font=(None, 28, 'bold'))
                elif action_type == 4 and test_var == 5:
                        error_window = Label(error, text="ERROR:\nŻeby wyjść z przerwy,\nnajpierw wejdź do pracy ;)", fg='red', font=(None, 28, 'bold'))
                elif action_type == 2:
                        error_window = Label(error, text="ERROR:\nJuż dzisiaj\nwychodziłeś z pracy", fg='red', font=(None, 28, 'bold'))
                elif action_type == 3:
                        error_window = Label(error, text="ERROR:\nJuż odnotowano\nwyjście na przerwę", fg='red', font=(None, 28, 'bold'))
                elif action_type == 4:
                        error_window = Label(error, text="ERROR:\nJuż odnotowano\npowrót z przerwy", fg='red', font=(None, 28, 'bold'))
                error_window.place(x=250, y=150, anchor="center")
                error.after(3000, lambda: error.destroy())
	root.destroy()

# Wejscie zmiennej podanej przy odpalaniu skryptu: (do pobrania id karty z systemu)
#print(sys.argv[1])


# OKNO 2 - MENU WYBORU OPCJI
# Call module

root = Tk()
root.title("Rejestrator czasu w firmie")

# Set window on full screen
root.overrideredirect(True)
root.overrideredirect(False)
root.attributes('-fullscreen',True)

# Set text and buttons
get_name = conn.cursor()
get_name.execute("SELECT imie FROM pracownicy WHERE karta='%s'" % card_id)
employee_name = cursor.fetchall()
employee_name = employee_name[0]
employee_name = employee_name[0]

get_fname = conn.cursor()
get_fname.execute("SELECT nazwisko FROM pracownicy WHERE karta='%s'" % card_id)
employee_fname = cursor.fetchall()
employee_fname = employee_fname[0]
employee_fname = employee_fname[0]

welcome = Label(root, text="Witaj " + employee_name + " " + employee_fname)
welcome.grid(row=0, column=0)

welcome2 = Label(root, text="Numer karty: " + str(card_id))
welcome2.grid(row=0, column=1)

enter_btn = Button(root, text="Wejscie", width=12, height=4, font = fnt.Font(size = 21), bg="green", activebackground="#006400", command= lambda: check_entry(employee_id, 1))
enter_btn.grid(row=1, column=0)

exit_btn = Button(root, text="Wyjscie", width=12, height=4, font = fnt.Font(size = 21), bg="red", activebackground="#FF6347", command= lambda: check_entry(employee_id, 2))
exit_btn.grid(row=1, column=1)

pause_start_btn = Button(root, text="Przerwa", width=12, height=4, font = fnt.Font(size = 21), command= lambda: check_entry(employee_id, 3))
pause_start_btn.grid(row=2, column=0)

pause_end_btn = Button(root, text="Koniec przerwy", width=12, height=4, font = fnt.Font(size = 21), bg="#808b96", activebackground="#808b96", command= lambda: check_entry(employee_id, 4))
pause_end_btn.grid(row=2, column=1)



# Start program with autokill after 3 seconds
root.after(5000, lambda: root.destroy())
root.mainloop()
conn.close()
conn2.close()

#os.system("python3 /etc/rcp/readrs.py " + success_check)
#os.system("python3 /etc/rcp/readrs.py")
#os.system("sh /etc/rcp/restart.sh")
#os.system("sudo killall -15 python3")

