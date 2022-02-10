import os
import sys
import datetime

i = 7
while i > 1:
    g = i - 
    f = open('/etc/skrypty/checkweb/log/checkweblog%s.txt' % g, 'r')
    temptext = f.read()
    f.close()
    f = open('/etc/skrypty/checkweb/log/checkweblog%s.txt' % i, 'w')
    f.write(temptext)
    f.close()
    i -= 1
x = datetime.datetime.now()
f = open('/etc/skrypty/checkweb/log/checkweblog1.txt', 'w')
f.write(x.strftime("Data logu: %x %X" + "\n"))
f.close()
