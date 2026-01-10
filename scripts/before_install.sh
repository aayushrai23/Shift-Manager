#!/bin/bash
set -e

echo "Preparing application directory and installing system tools..."

# Update package list
apt-get update -y

# Install required tools
apt-get install -y awscli jq docker.io docker-compose

# Ensure app directory exists
mkdir -p /var/www/shift-manager
chown -R ubuntu:ubuntu /var/www/shift-manager

