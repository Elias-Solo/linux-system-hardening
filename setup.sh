#!/bin/bash

# Update and upgrade the system

sudo apt update || sudo apt upgrade -y

# Install necessary packages

sudo apt install -y ufw libpam-pwquality

# Configure UFW

sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Enforce strong password policy

if ! grep -q "pam_pwquality.so" /etc/pam.d/common-password; then
   echo "password requisite pam_pwquality.so retry=3 ninlen=12 difok=3" | sudo tee -a /etc/pam.d/common-pawword
fi

# Disable root SSH login

sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "System Hardening complete."
