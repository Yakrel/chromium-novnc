#!/bin/bash
set -e

echo "Starting container setup..."

# Create necessary directories with proper permissions
mkdir -p $HOME/.vnc
mkdir -p $HOME/.config/chromium
mkdir -p /var/log

# Set correct permissions
chown -R alpine:alpine $HOME
chown -R alpine:alpine /var/log

# Set VNC password
echo "Setting VNC password..."
x11vnc -storepasswd $VNC_PASSWORD $HOME/.vnc/passwd
chown -R alpine:alpine $HOME/.vnc

# Set supervisor config permissions
chmod 644 /etc/supervisor/conf.d/supervisor.conf

echo "Starting supervisord..."
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf
