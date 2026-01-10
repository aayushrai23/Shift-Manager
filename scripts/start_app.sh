#!/bin/bash
set -e

echo "Starting Docker containers..."

APP_DIR="/var/www/Shift-Manager"

cd "$APP_DIR"

docker compose build
docker compose up -d

