#!/bin/bash
set -e

# Set VNC password
mkdir -p $HOME/.vnc
x11vnc -storepasswd $VNC_PASSWORD $HOME/.vnc/passwd

# Run supervisord
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf
