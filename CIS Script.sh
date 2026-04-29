#!/bin/bash

echo "==== CIS Detection Report ====" > report.txt

echo "[1] Checking SSH root login..." >> report.txt
grep -i PermitRootLogin /etc/ssh/sshd_config >> report.txt

echo "[2] Checking UFW firewall status..." >> report.txt
ufw status >> report.txt

echo "[3] Checking password policy..." >> report.txt
grep PASS_MAX_DAYS /etc/login.defs >> report.txt

echo "[4] Checking world-writable files..." >> report.txt
find / -xdev -type f -perm -0002 2>/dev/null >> report.txt

echo "[5] Checking running services..." >> report.txt
systemctl list-units --type=service --state=running >> report.txt

echo "[6] Checking auditd status..." >> report.txt
systemctl status auditd >> report.txt

echo "[7] Checking updates..." >> report.txt
apt list --upgradable 2>/dev/null >> report.txt

echo "==== Scan Complete ===="