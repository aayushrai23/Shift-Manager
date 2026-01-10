#!/bin/bash
set -e

echo "Stopping existing PM2 app if running..."

pm2 stop shift-manager || echo "App not running"
