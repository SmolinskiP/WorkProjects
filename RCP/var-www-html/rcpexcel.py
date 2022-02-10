#!/usr/bin/env python3

import mysql.connector as database
from datetime import datetime, date, timedelta
#import datetime
import time
import sys
import xlsxwriter
from time import gmtime
from time import strftime
int_total_time = 0

def daterange(date1, date2):
    for n in range(int ((date2 - date1).days)+1):
        yield date1 + timedelta(n)

start_dt = date(2022,1,1)
end_dt = date(2022,12,30)

weekdays = [5,6]
weekends = []
for dt in daterange(start_dt, end_dt):
    if dt.weekday() in weekdays:
        weekends.append(dt.strftime("%Y-%m-%d"))
weekends.append("2022-01-06")
weekends.append("2022-04-18")
weekends.append("2022-05-03")
weekends.append("2022-06-16")
weekends.append("2022-08-15")
weekends.append("2022-11-01")
weekends.append("2022-11-11")
weekends.append("2022-12-25")
weekends.append("2022-12-26")
try:
    conn = database.connect(
        user="rcp",
        password="rcp",
        host="x.x.x.x",
        database="RFID"
    )
except database.Error as e:
    print(f"Nie udalo sie polaczyc z baza danych MariaDB: {e}")
    sys.exit(1)

cursor = conn.cursor()
workbook = xlsxwriter.Workbook('/var/www/html/rcp/Obecnosc.xlsx')
cursor.execute("SELECT imie, nazwisko, id, palacz FROM pracownicy WHERE lokalizacja = 1 ORDER BY nazwisko")
sql_query_1 = cursor.fetchall()

red_cell = workbook.add_format({'font_color': 'white', 'bg_color': 'red', 'bold': True})
orange_cell = workbook.add_format({'font_color': 'white', 'bg_color': 'orange', 'bold': True})
green_cell = workbook.add_format({'font_color': 'white', 'bg_color': 'green', 'bold': True})
black_cell = workbook.add_format({'font_color': 'black'})
time_cell = workbook.add_format({'num_format': 'hh:mm:ss'})
white_cell = workbook.add_format({'font_color': 'white'})

for (imie, nazwisko, id, palacz) in sql_query_1:
    workbook.add_worksheet(nazwisko + " " + imie)
    worksheet = workbook.get_worksheet_by_name(nazwisko + " " + imie)
    worksheet.write(0, 0, imie)
    worksheet.write(0, 1, nazwisko)
    worksheet.write(2, 0, "Surowe dane poniżej:")
    worksheet.write(3, 0, "Dzień:")
    worksheet.write(3, 1, "Wejście:")
    worksheet.write(3, 2, "Wyjście:")
    worksheet.write(3, 7, "Etat:")
    worksheet.write(3, 4, "Godzina wejścia:")
    worksheet.write(3, 5, "Godzina wyjścia:")
    worksheet.write(3, 8, "Liczba przepracowanych godzin brutto:")
    worksheet.write(3, 9, "Liczba przepracowanych godzin netto:")
    worksheet.write(3, 10, "Nadgodziny:")
    worksheet.write_formula('K36', '=SUM(K5:K35)')
    worksheet.write_formula('I36', '=SUM(I5:I35)')
    worksheet.write_formula('H36', '=SUM(H5:H35)')
    if palacz == 1:
        worksheet.write(0, 3, "Palacz", red_cell)
    x = 1
    while x < 32:
        cell2_type = black_cell
        if x < 10:
            y = "0" + str(x)
        else:
            y = str(x)

        cursor.execute("SELECT DATE_FORMAT(TIME, '%H:%i:%s') FROM obecnosc WHERE pracownik = " + str(id) + " AND action = 1 AND time LIKE '" + datetime.today().strftime('%Y-%m-') + y + "%'")
        sql_query_time_1 = cursor.fetchall()
        sql_query_time_1 = str(sql_query_time_1)[3:-4]
        h = sql_query_time_1[0:2]
        if h:
            h = int(h)
        m = sql_query_time_1[3:5]
        if m:
            m = int(m)
        s = sql_query_time_1[6:8]
        if s:
            s = int(s)
            entry_total_time = int(h) * 3600 + int(m) * 60 + int(s)
            del h
            del m
            del s

        cursor.execute("SELECT DATE_FORMAT(TIME, '%H:%i:%s') FROM obecnosc WHERE pracownik = " + str(id) + " AND action = 2 AND time LIKE '" + datetime.today().strftime('%Y-%m-') + y + "%'")
        sql_query_time_2 = cursor.fetchall()
        sql_query_time_2 = str(sql_query_time_2)[3:-4]
        h = sql_query_time_2[0:2]
        if h:
            h = int(h)
        m = sql_query_time_2[3:5]
        if m:
            m = int(m)
        s = sql_query_time_2[6:8]
        if s:
            s = int(s)
            exit_total_time = int(h) * 3600 + int(m) * 60 + int(s)
            del h
            del m
            del s
#        try:
#            variable = 0
#        except:
#            pass
        try:
            int_total_time = exit_total_time - entry_total_time
            if int_total_time < 28800:
                 cell2_type = red_cell
            total_total_time = strftime("%H:%M:%S", gmtime(int_total_time))
#            del int_total_time
            del exit_total_time
            del entry_total_time
        except:
            cell2_type = black_cell
#            total_total_time = "brak"
        worksheet = workbook.get_worksheet_by_name(nazwisko + " " + imie)
        if 'total_total_time' in locals():
            worksheet.write(x+3, 9, total_total_time, cell2_type)
            del total_total_time
        actual_date = datetime.today().strftime('%Y-%m-') + y
#        actual_date = datetime.today().strftime('%Y-%m-') + y
        if actual_date in weekends:
            day_cell = green_cell
        else:
            day_cell = black_cell
        worksheet.write(x+3, 0, datetime.today().strftime('%Y-%m-') + y, day_cell)
#        worksheet.write_formula('K'+str(x+4), '=I' + str(x+4) + '-H' + str(x+4))
        worksheet.write_formula('I'+str(x+4), '=ROUND(J'+str(x+4)+'*24,0)')
        worksheet.write_formula('K'+str(x+4), '=IF(U' + str(x+4) + '=TRUE,V' + str(x+4) + ',"")'  )
        worksheet.write_formula('Z'+str(x+4), '=(L' + str(x+4) + "*24)-8", white_cell)
        worksheet.write_formula('Y'+str(x+4), '=ROUND(Z' + str(x+4) + ',0)', white_cell)
        worksheet.write_formula('X'+str(x+4), '=MROUND(J' + str(x+4) + '*24,0.0001)', white_cell)
        worksheet.write_formula('W'+str(x+4), '=MROUND(X' + str(x+4) + '-8,0.0001)', white_cell)
        worksheet.write_formula('V'+str(x+4), '=FLOOR(W' + str(x+4) + ',0.5)', white_cell)
        worksheet.write_formula('U'+str(x+4), '=ISNUMBER(V' + str(x+4) + ')', white_cell)
#Baska inny etat
        if id == 8:
            worksheet.write_formula('H'+str(x+4), '=IF(I' + str(x+4) + '>=0.01,7,I' + str(x+4) + ')')
        else:
            worksheet.write_formula('H'+str(x+4), '=IF(I' + str(x+4) + '>=0.01,8,I' + str(x+4) + ')')

        x += 1
    cursor.execute("SELECT pracownik, time, action FROM obecnosc WHERE pracownik = " + str(id) + " AND TIME LIKE '2022-02-%' ORDER BY pracownik, time, action")
#DOKONCZYC TO DZIADOSTWO    cursor.execute("SELECT pracownik, time, action FROM obecnosc WHERE pracownik = " + str(id) + " AND TIME LIKE '" + datetime.today().strftime('%Y-%m-') + "' ORDER BY pracownik, time, action")
    sql_query_2 = cursor.fetchall()
    row = 4
    for (pracownik, time, action) in sql_query_2:
        worksheet = workbook.get_worksheet_by_name(nazwisko + " " + imie)
        col = action
        time_string = str(time)
        row = int(time_string[8:10])
        if int((time_string[14:16])) > 0 and action == 1 and int((time_string[14:16])) < 30:
            cell_type = orange_cell
            if int_total_time < 28800:
                cell_type = red_cell
        elif int((time_string[14:16])) > 55 and action ==2:
            cell_type = orange_cell
            if int_total_time < 28800:
                cell_type = red_cell
        else:
            cell_type = black_cell
        if int(time_string[14:16]) >= 45 and action == 1:
            entry_hour = int(time_string[11:13]) + 1
            entry_type = black_cell
        elif int(time_string[14:16]) <= 20 and action == 1:
            entry_hour = int(time_string[11:13])
            entry_type = black_cell
        elif int(time_string[14:16]) > 20 and int(time_string[14:16]) < 45 and action == 1:
            entry_hour = "Wymaga uwagi"
            if (pracownik == 7 or pracownik == 128 or pracownik == 21):
                entry_hour = time_string[11:16]
            entry_type = red_cell

        if int(time_string[14:16]) >= 45 and action == 2:
            exit_hour = int(time_string[11:13]) + 1
            exit_type = black_cell
        elif int(time_string[14:16]) <= 15 and action == 2:
            exit_hour = int(time_string[11:13])
            exit_type = black_cell
        elif int(time_string[14:16]) > 15 and int(time_string[14:16]) < 45 and action == 2:
            exit_hour = "Wymaga uwagi"
            if (pracownik == 7 or pracownik == 128 or pracownik == 21):
                exit_hour = time_string[11:16]
            exit_type = red_cell

#Wyjatek dla : 7 -  128 -  21 - 
        if (pracownik == 7 or pracownik == 128 or pracownik == 21):
            print(pracownik)
            cell_type = black_cell
            entry_type = black_cell
            exit_type = black_cell
        if action == 1 or action == 2:
            worksheet.write(row + 3, col, time_string[10:], cell_type)
        elif action == 5:
            worksheet.write(row + 3, 3, "Urlop wypoczynkowy", cell_type)
        if 'entry_hour' in locals():
            worksheet.write(row + 3, 4, entry_hour, entry_type)
            del entry_hour
        if 'exit_hour' in locals():
            worksheet.write(row + 3, 5, exit_hour, exit_type)
            del exit_hour

#Baska krotszy etat
#        if pracownik == 8:
#            worksheet.write(row + 3, 7, 7)
#            worksheet.write_formula('H'+str(row+3), '=IF(I' + str(row+3) + '>=7,7,I' + str(row+3) + ')')

workbook.close()
conn.close()
