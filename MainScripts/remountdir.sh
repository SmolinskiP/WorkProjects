#!/bin/sh

sudo systemctl stop smbd
sudo umount -a
sudo mount -a
sudo sh /etc/skrypty/mountdir.sh
sudo systemctl start smbd

