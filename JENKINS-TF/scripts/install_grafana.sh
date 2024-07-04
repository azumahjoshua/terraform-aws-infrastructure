#!/bin/bash

# Function to print and execute commands
run() {
  echo "Running: $1"
  eval "$1"
}

# Update package lists
run "sudo yum update -y"

# Add Grafana repository
run "sudo tee /etc/yum.repos.d/grafana.repo > /dev/null <<EOF
[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
EOF"

# Install Grafana
run "sudo yum install -y grafana"

# Start and enable Grafana service
run "sudo systemctl start grafana-server"
run "sudo systemctl enable grafana-server"

# Check Grafana service status
run "sudo systemctl status grafana-server"
