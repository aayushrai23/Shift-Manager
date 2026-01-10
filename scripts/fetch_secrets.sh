#!/bin/bash
set -e

echo "Fetching secrets from AWS Secrets Manager..."

SECRET_NAME="shift-manager-env"
REGION="ap-south-1"

BACKEND_ENV_PATH="/var/www/shift-manager/backend/.env"

SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_NAME" \
  --region "$REGION" \
  --query SecretString \
  --output text)

echo "Writing backend .env file..."

mkdir -p /var/www/shift-manager/backend

echo "$SECRET_JSON" | jq -r '
  to_entries | .[] | "\(.key)=\(.value)"
' > "$BACKEND_ENV_PATH"

chown ubuntu:ubuntu "$BACKEND_ENV_PATH"
chmod 600 "$BACKEND_ENV_PATH"

echo "Backend .env created successfully"

