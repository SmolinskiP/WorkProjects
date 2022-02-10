from tkinter import *
import mysql.connector as database
import sys
from datetime import datetime
import time
import os
from tkinter import font as fnt

card_id = "472198r"
action = 2
employee_id = 112

try:
    conn = database.connect(
        user="rcp",
        password="PDArcpSERWIS",
        host="localhost",
        database="RFID"
    )
except database.Error as e:
    print(f"Nie udalo sie polaczyc z baza danych MariaDB: {e}")
    sys.exit(1)

cursor = conn.cursor()

actual_time = datetime.today().strftime('%Y-%m-%d')
print(actual_time)

employee_id = 112

cursor.execute("SELECT id FROM obecnosc WHERE action='%s' AND pracownik='%s' AND time > '%s'" % (action, employee_id, actual_time))
result = cursor.fetchall()
if not result:
    print("Not found")
else:
    print(result)
