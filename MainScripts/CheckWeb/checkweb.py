import urllib
import os
import sys
import socket
import datetime

def checkInternetSocket(host="8.8.8.8", port=53, timeout=3):
    try:
        socket.setdefaulttimeout(timeout)
        socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect((host, port))
        return True
#dotestow        return False
    except socket.error as ex:
        print(ex)
        return False
#dotestow        return True

def connect(host='http://google.com'):
    try:
        urllib.urlopen(host) #Python 3.x
        return True
    except:
        return False

x = datetime.datetime.now()
#if connect():
#    os.system("sudo sh /etc/skrypty/checkweb/sendsms.sh")
#    os.system("echo Jest internet")
#else:
#    os.system("sudo sh /etc/skrypty/checkweb/sendsms2.sh")
#    os.system("echo Ni mo")

if checkInternetSocket():
#    os.system("sudo sh /etc/skrypty/checkweb/sendsms.sh")
    os.system("echo Jest internet")
    f = open('/etc/skrypty/checkweb/count.txt', 'w')
    f.write("0")
    f.close()
    f = open('/etc/skrypty/checkweb/log/checkweblog1.txt', 'a')
    f.write(x.strftime("Dzialam i dostarczam grzecznie internet - %x %X" + "\n"))
    f.close
else:
    f = open('/etc/skrypty/checkweb/count.txt', 'r')
    filecontent = int(f.read())
    f.close()
    os.system("sudo sh /etc/skrypty/checkweb/sendsms2.sh")
    os.system("echo Pierwszy else")
    if filecontent < 3:
        filecontent+=1
        f = open('/etc/skrypty/checkweb/count.txt', 'w')
        f.write(str(filecontent))
        f.close()
        os.system("echo Incrementing file - no internet access")
        f = open('/etc/skrypty/checkweb/log/checkweblog1.txt', 'a')
#j org        f.write(x.strftime("Nie mam internetu: próba numer ",str(filecontent)," - %x %X" +" \n"))
        f.write(x.strftime("Nie mam internetu: próba numer "+str(filecontent)+" - %x %X" +" \n"))
        f.close
    else:
        f = open('/etc/skrypty/checkweb/count.txt', 'w')
        f.write("0")
        f.close()
        f = open('/etc/skrypty/checkweb/log/checkweblog1.txt', 'a')
        f.write(x.strftime("PRZELACZAM INTERNET NA GSM PO "+str(filecontent + 1)+" nieudanych probach!!! - %x %X" + "\n"))
        f.close
        os.system("sudo sh /etc/skrypty/checkweb/firewall_gsm.sh")
        os.system("sudo sh /etc/skrypty/checkweb/sendsms3.sh")
        os.system("echo Turning on GSM internet after 3 attempts")
        os.system("sudo systemctl stop niceshaper")
