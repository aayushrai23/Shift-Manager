#!/bin/bash
set -e

echo "Stopping Docker containers..."

APP_DIR="/var/www/Shift-Manager"

cd "$APP_DIR" || exit 0

docker compose down || docker-compose down || true

