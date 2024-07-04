#!/bin/bash

# Function to print and execute commands
run() {
  echo "Running: $1"
  eval "$1"
}

# Create Node Exporter user
run "sudo useradd --system --no-create-home --shell /bin/false node_exporter"

# Download and extract Node Exporter
NODE_EXPORTER_VERSION="1.6.1"
run "wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
run "tar -xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

# Move binary
run "sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/"

# Clean up
run "rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*"

# Create systemd service file
sudo bash -c 'cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd, start and enable Node Exporter service
run "sudo systemctl daemon-reload"
run "sudo systemctl start node_exporter"
run "sudo systemctl enable node_exporter"
run "sudo systemctl status node_exporter"

