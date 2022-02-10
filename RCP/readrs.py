#import base64
#import codecs
#import time
import serial
import os
import sys
from time import strftime
#os.system("clear")
#___________________________________________TKINTER
# importing whole module
from tkinter import *
from tkinter.ttk import *
from time import strftime

ser = serial.Serial(
        port='/dev/serial0',
        baudrate=9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=0.2,
#       dsrdtr=True
)

#def readcard():
#	while 1:
#		x=ser.readline()
#		if len(x) >= 5:
#			x = str(x)
#			x = x[6:14]
#			os.system("python3 /etc/rcp/rcp.py " + x)
#			root.after(200, readcard)
#			break


# creating tkinter window
root1 = Tk()
root1.title('Clock')

# This function is used to
# display time on the label
def time():
       string = "\nPrzyłóż kartę\n" + strftime('   %H:%M:%S')
       lbl.config(text = string)
       lbl.after(200, time)
       if (ser.inWaiting() > 3):
#             root1.destroy()
#             lbl.destroy()
             x=ser.readline()
             x = str(x)
             x = x[6:14]
             with open("/etc/rcp/karty.txt", "w") as fp:
#                 date = datetime.now().strftime("%Y_%m_%d %H:%M:%S")
#                 fp.write(date)
                 fp.write(x)
             os.system("python3 /etc/rcp/rcp.py " + x)

#       x=ser.readline()
#       if len(x) >= 5:
#               x = str(x)
#               x = x[6:14]
#               os.system("python3 /etc/rcp/rcp.py " + x)

#       while 1:
#               x=ser.readline()
#               if len(x) >= 5:
#                       x = str(x)
#                       x = x[6:14]
#                       os.system("python3 /etc/rcp/rcp.py " + x)
#                       lbl.destroy()
#                       lbl.after(200, time)
#                       break

# Styling the label widget so that clock
# will look more attractive

img = PhotoImage(file='/etc/rcp/pp.png')


lbl = Label(root1, image=img, compound='top', font = ('calibri', 45, 'bold'))
root1.overrideredirect(True)
root1.overrideredirect(False)
root1.attributes('-fullscreen',True)
# Placing clock at the centre
# of the tkinter window
lbl.pack(anchor = 'center')


time()




#ser.flushInput()
#os.system("clear")


#root.after(200, readcard)
root1.mainloop()


#print("Przyłóż kartę do czytnika")
#print(success_check)

