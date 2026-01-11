	#!/bin/bash
set -e

echo "🚀 Preparing application directory and installing system tools..."

# 1️⃣ Update packages
sudo apt-get update -y

# 2️⃣ Install base dependencies
sudo apt-get install -y \
  ca-certificates \
  curl \
  unzip \
  jq

# 3️⃣ Remove conflicting old Docker packages if present
sudo apt-get remove -y docker docker.io containerd runc || true

# 4️⃣ Install Docker from OFFICIAL Docker repo
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin

# 5️⃣ Enable & start Docker
sudo systemctl enable docker
sudo systemctl start docker

# 6️⃣ Install AWS CLI v2 (only if missing)
if ! command -v aws >/dev/null 2>&1; then
  echo "📦 Installing AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -q awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
fi

# 7️⃣ Verify installations
docker --version
docker compose version
aws --version

# 8️⃣ Prepare application directory
sudo mkdir -p /var/www/shift-manager
sudo chown -R ubuntu:ubuntu /var/www/shift-manager

echo "✅ BeforeInstall completed successfully"

