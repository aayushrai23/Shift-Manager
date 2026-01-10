#!/bin/bash
set -e

APP_DIR="/var/www/Shift-Manager"

cd "$APP_DIR"

docker compose down || true
docker compose build
docker compose up -d

