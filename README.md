# chromium-novnc

Run Chromium browser in a container, accessible through a web browser using noVNC.

## Features

- Based on Alpine Linux for minimal image size
- Latest versions of Chromium and noVNC
- Accessible through any modern web browser
- Password protection for the VNC connection

## Usage

### Quick Start

```bash
# Start with default settings
docker-compose up -d

# Access in your browser
# http://localhost:7171/vnc.html
```

### Custom Password

```bash
# Set a custom VNC password
VNC_PASSWORD=mysecretpassword docker-compose up -d
```

### Custom Port

Edit the `docker-compose.yml` file to change the default port (7171).

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| VNC_PASSWORD | Password for VNC access | password |
| VNC_RESOLUTION | Screen resolution | 1920x1080 |

## Building Manually

```bash
# Build the image
docker build -t chromium-novnc .

# Run the container
docker run -p 6080:6080 -e VNC_PASSWORD=mysecretpassword chromium-novnc
```

## License

MIT License - See LICENSE file for details