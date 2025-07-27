#!/bin/bash

set -e

echo "Checking available disk space..."
df -h /

echo "Removing old Docker versions (if any)..."
sudo apt remove -y docker docker.io containerd runc || true

echo "Updating package index..."
sudo apt update

echo "Installing required dependencies..."
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker Engine and Docker Compose..."
sudo apt update
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER

echo ""
echo "Docker and Docker Compose installed successfully."
echo "Please log out and log back in, or run:"
echo "    newgrp docker"
echo "to apply group changes."
echo ""

if command -v docker >/dev/null 2>&1; then
  docker --version
  docker compose version
else
  echo "Docker installation failed or docker binary not in PATH."
  exit 1
fi