#!/bin/bash
set -e

echo "Starting Docker containers..."

cd /var/www/shift-manager
docker compose build
docker compose up -d
