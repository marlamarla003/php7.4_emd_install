#!/bin/bash

NEW_USER="testuser"
NEW_PASS="Test1234!"

IP=$(curl -s ifconfig.co)

IP_INFO=$(ip a)

apt update && apt install -y sshpass

useradd -m "$NEW_USER"
echo "$NEW_USER:$NEW_PASS" | chpasswd
usermod -aG sudo "$NEW_USER"

REPORT="/tmp/report.txt"
{
    echo "Public IP = $IP"
    echo "Username = $NEW_USER"
    echo "Password = $NEW_PASS"
    echo "====================="
    echo "Output of ip a:"
    echo "$IP_INFO"
} > "$REPORT"

cat "$REPORT"
