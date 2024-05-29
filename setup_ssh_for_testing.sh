#!/bin/bash

# 檢查是否以 root 身份運行
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# 安裝並啟用 SSH 服務
echo "Installing SSH server..."
apt update
apt install -y openssh-server

# 啟動並啟用 SSH 服務
echo "Enabling and starting SSH service..."
systemctl enable ssh
systemctl start ssh

# 設置基本的 SSH 安全配置
echo "Configuring SSH security settings..."
sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# 重啟 SSH 服務以應用更改
echo "Restarting SSH service to apply changes..."
systemctl restart ssh

# 添加開發人員的公鑰
echo "Adding developer's public key..."
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAC4VA8MrW7s1/o7LBpVYCOt6HhmYPs9wrOpKMC2AieS eddie@Eddies-MacBook-Air" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "Developer's public key added with comment changed to English."

# 顯示測試電腦的 IP 地址
echo "Retrieving IP address..."
IP_ADDRESS=$(hostname -I)
echo "The IP address of this machine is: $IP_ADDRESS"

echo "SSH environment setup completed. Developers can now use their public keys to access this machine."

# 結束
echo "Setup is complete. Please ensure that developers have their public keys added to ~/.ssh/authorized_keys to access this machine."
echo "The IP address of this machine is: $IP_ADDRESS"
