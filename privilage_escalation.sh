#!/bin/bash
#checking SUID files
echo "[*] Checking for SUID files..."
find / -perm -4000 -type f 2>/dev/null
#writable files owned by root user
echo "[*] Checking for writable files owned by root..."
find / -writable -type f -user root 2>/dev/null
#cronjobs
echo "[*] Checking for cron jobs..."
cat /etc/crontab
ls -la /etc/cron.*
#capabilities
echo "[*] Checking for capabilities..."
getcap -r / 2>/dev/null
#environment Path
echo "[*] Checking environment PATH..."
echo $PATH
#cron tabs
echo "[*] Checking for cronjobs..."
cat /etc/crontab
ls -la /etc/cron.*
#wek file permission
echo "[*] Checking for for file permission..."
find / -name "*.sh" -type f -perm -o+w 2>/dev/null
#running proccesses by root
echo "[*] Checking for proccesses..."
ps aux | grep root
#if no password activities exist then it's the easiest way
echo "[*] Checking for nonpassword..."
sudo -l
#checking each intepreter
echo "[*] Checking for each entepreter..."
which python
which perl
which ruby
which gcc
#checking each path
echo "[*] Checking for each file..."
ls -l /etc/passwd
ls -l /etc/shadow
ls -l /etc/sudoers
#getting content of each files
echo "[*] Checking for data in each file..."
cat /etc/passwd
cat /etc/shadow
cat /etc/sudoers