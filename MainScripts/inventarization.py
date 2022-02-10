import pandas as pd
import pyodbc 

import mysql.connector
from mysql.connector import errorcode
try:
  cnxn = mysql.connector.connect(user='asd', password='asd',
                                host='127.0.0.1', database='siec')
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with your user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
else:
  print("You are connected!")

script = ''' 
SELECT * FROM test_sprzety4
'''

df = pd.read_sql_query(script, cnxn)

writer = pd.ExcelWriter('/home/patryk/Sprzet_IT_Plonsk.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/kasia/Sprzet_IT_Plonsk.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/rafal/Sprzet_IT_Plonsk.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()

script = ''' 
SELECT komputery.id, komputery.komentarz, komputery.procesor, komputery.SN, komputery.mac FROM komputery WHERE komputery.lokalizacja = 2 ORDER BY komputery.komentarz
'''

df = pd.read_sql_query(script, cnxn)

writer = pd.ExcelWriter('/home/patryk/Sprzet_IT_Warszawa.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/kasia/Sprzet_IT_Warszawa.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/rafal/Sprzet_IT_Warszawa.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()

script = '''
SELECT monitory.producent, monitory.model, monitory.cale, monitory.komentarz
FROM monitory
WHERE monitory.lokal = 2
ORDER BY monitory.Producent
'''

df = pd.read_sql_query(script, cnxn)

writer = pd.ExcelWriter('/home/patryk/Monitory_Warszawa.xlsx')
df.to_excel(writer, sheet_name='Monitory_WWA')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/kasia/Monitory_Warszawa.xlsx')
df.to_excel(writer, sheet_name='Monitory_WWA')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/rafal/Monitory_Warszawa.xlsx')
df.to_excel(writer, sheet_name='Monitory_WWA')
writer.save()


script = ''' 
SELECT * FROM monitory WHERE lokal = 0
'''

df = pd.read_sql_query(script, cnxn)

writer = pd.ExcelWriter('/home/patryk/Monitory_reszta.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/kasia/Monitory_reszta.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()
writer = pd.ExcelWriter('/mnt/md11/home/rafal/Monitory_reszta.xlsx')
df.to_excel(writer, sheet_name='IT_Plonsk')
writer.save()

cnxn.close()
