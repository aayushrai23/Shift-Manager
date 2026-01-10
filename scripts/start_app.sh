#!/bin/bash
set -e

echo "Starting application..."

cd /var/www/shift-manager

npm install --production

pm2 start app.js --name shift-manager || pm2 restart shift-manager
pm2 save
