FROM alpine:latest

# Set environment variables
ENV HOME=/home/alpine \
    DEBIAN_FRONTEND=noninteractive \
    VNC_RESOLUTION=1920x1080 \
    VNC_DPI=96 \
    VNC_PASSWORD=password

# Install necessary packages
RUN apk update && apk add --no-cache \
    xvfb \
    x11vnc \
    supervisor \
    fluxbox \
    chromium \
    dbus-x11 \
    bash \
    procps \
    curl \
    wget \
    git \
    openssl \
    socat \
    xterm \
    font-noto \
    font-noto-emoji \
    ttf-dejavu \
    mesa-dri-gallium \
    libstdc++ \
    libgcc \
    musl \
    python3 \
    py3-pip \
    py3-numpy \
    sudo

# Create a non-root user
RUN adduser -D -u 1000 alpine && \
    mkdir -p ${HOME} && \
    mkdir -p ${HOME}/.config && \
    mkdir -p ${HOME}/.vnc && \
    mkdir -p /var/log && \
    chown -R alpine:alpine ${HOME} && \
    chmod 755 ${HOME}

# Set up noVNC
WORKDIR /opt
RUN git clone --depth 1 https://github.com/novnc/noVNC.git && \
    git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html && \
    chmod -R 755 /opt/noVNC

# Add script files
COPY scripts/entrypoint.sh /opt/
COPY scripts/supervisor.conf /etc/supervisor/conf.d/
RUN chmod +x /opt/entrypoint.sh

# Set up working directory
WORKDIR ${HOME}

# Expose ports
EXPOSE 5900 6080

# Set entry point
ENTRYPOINT ["/opt/entrypoint.sh"]
