#!/bin/bash
echo "Setting Up Web Application Env"

# Update System
sudo apt update -y

# Install Utility Softwares
sudo apt install -y zip unzip

# Install NGINX Web Server
sudo apt install -y nginx

# Clean Up Sample Files in Document Root
sudo rm -rf /var/www/html

# Create New Document Root
sudo mkdir -p /var/www/html

# Deploy Login App
sudo git clone https://github.com/ravi2krishna/login-2433.git /var/www/html
