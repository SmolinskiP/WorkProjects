import os

os.system("ls -al /mnt/md11/samba/profiles/ > /etc/skrypty/lsal.txt")

file = open("/etc/skrypty/lsal.txt", "r")
lines = file.readlines()[3:]

for line in lines:
	lis = list(line.split(" "))
	lenght = len(lis)
	username = lis[lenght - 1]
	username = username[:-1]
	userdir = "\"PDA\\" + username + "\""
	command = "sudo chown -R " + userdir + " /mnt/md11/samba/profiles/" + username
	print("Zmieniam uprawnienia dla uzytkownika " + username + ". Uzyta komenda:")
	print(command)
	os.system(command)
