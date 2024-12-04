#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing prerequisites..."
sudo apt install -y wget qbittorrent-nox 

cd Setup
sudo bash install.sh
sudo mv jellyfin.sh /etc/jellyfin/
sudo mv jellyfin.service /etc/systemd/system
echo "Installing Libmali-valhall for hardware acceleration..."
sudo dpkg -i libmali-valhall-g610-g13p0-gbm_1.9-1_arm64.deb

if ! id -u qbittorrent &>/dev/null; then
    echo "Creating qbittorrent system user..."
    sudo useradd --system --no-create-home --shell /usr/sbin/nologin qbittorrent
fi

sudo mkdir -p /var/lib/qbittorrent
sudo chown qbittorrent:qbittorrent /var/lib/qbittorrent

# Create systemd service file for qBittorrent-nox
echo "Configuring qBittorrent-nox service..."
sudo tee /etc/systemd/system/qbittorrent-nox.service > /dev/null <<EOF
[Unit]
Description=qBittorrent Command Line Client
After=network.target

[Service]
User=qbittorrent
Group=qbittorrent
ExecStart=/usr/bin/qbittorrent-nox --webui-port=8080
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon and enable services
echo "Enabling and starting services..."
sudo systemctl daemon-reload
sudo systemctl enable jellyfin qbittorrent-nox
sudo systemctl start jellyfin qbittorrent-nox

# Add jellyfin and qbittorrent users to 'pi' group for access to /home/pi/Downloads
echo "Setting up permissions for /home/pi/Downloads..."
sudo usermod -aG pi jellyfin
sudo usermod -aG pi qbittorrent

# Ensure 'pi' group has read/write/execute permissions on /home/pi/Downloads
sudo chgrp -R pi /home/pi/Downloads
sudo chmod -R 770 /home/pi/Downloads

echo "Installation and configuration complete."

