#!/bin/bash

# 安裝並啟用 SSH 服務
echo "Installing SSH server..."
sudo apt update
sudo apt install -y openssh-server
sudo apt install -y tmux

# 啟動並啟用 SSH 服務
echo "Enabling and starting SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh

# 設置基本的 SSH 安全配置
echo "Configuring SSH security settings..."
sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 重啟 SSH 服務以應用更改
echo "Restarting SSH service to apply changes..."
sudo systemctl restart ssh

# 添加開發人員的公鑰
echo "Adding developer's public key..."
rm -rf ~/.ssh
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAC4VA8MrW7s1/o7LBpVYCOt6HhmYPs9wrOpKMC2AieS eddie@Eddies-MacBook-Air" >> ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzTw+7aAwum1eCskGQg00yVXGdRwu7LR0Xwsu/JRYL7 tunnel@ubuntu18" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "Developer's public key added with comment changed to English."

# 顯示測試電腦的 IP 地址
echo "Retrieving IP address..."
IP_ADDRESS=$(hostname -I)
echo "The IP address of this machine is: $IP_ADDRESS"

echo "SSH environment setup completed. Developers can now use their public keys to access this machine."

SSH_PRIVATE_KEY="-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
"

echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Ed25519 SSH keys have been added and are ready for use."

# 結束
echo "Setup is complete. Please ensure that developers have their public keys added to ~/.ssh/authorized_keys to access this machine."
echo "The IP address of this machine is: $IP_ADDRESS"

# 'ssh -o StrictHostKeyChecking=no' is risky
# ssh -o StrictHostKeyChecking=no -R 43022:localhost:22 tunnel@{{Your Proxy Host}}

HOST="newhost.example.com"
ssh-keyscan -t ed25519 -H $HOST >> ~/.ssh/known_hosts
# ssh-keygen -R $HOST  # remove old key

tmux kill-server
sleep 1
tmux new-session -d -s ssh_session
tmux send-keys -t ssh_session "ssh -R 43022:localhost:22 tunnel@{{Your Proxy Host}}" C-m
# sudo lsof -i :43022 | grep ssh | awk '{print $2}' | xargs sudo kill -9 # kill process
