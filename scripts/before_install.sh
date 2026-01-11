#!/bin/bash
set -e

echo "🚀 Preparing application directory and installing system tools..."

# 1️⃣ Update package list
sudo apt-get update -y

# 2️⃣ Install required system tools
sudo apt-get install -y \
  ca-certificates \
  curl \
  unzip \
  jq \
  docker.io \
  docker-compose

# 3️⃣ Enable & start Docker
sudo systemctl enable docker
sudo systemctl start docker

# 4️⃣ Install AWS CLI v2 (only if not already installed)
if ! command -v aws >/dev/null 2>&1; then
  echo "📦 Installing AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -q awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
fi

# 5️⃣ Verify AWS CLI
aws --version

# 6️⃣ Prepare application directory
sudo mkdir -p /var/www/shift-manager
sudo chown -R ubuntu:ubuntu /var/www/shift-manager

echo "✅ BeforeInstall completed successfully"

