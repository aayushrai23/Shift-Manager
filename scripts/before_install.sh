#!/bin/bash
set -e

echo "Preparing application directory..."

mkdir -p /var/www/shift-manager
chown -R ubuntu:ubuntu /var/www/shift-manager
