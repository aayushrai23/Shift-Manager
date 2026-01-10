#!/bin/bash
set -e

echo "Fetching secrets from AWS Secrets Manager..."

SECRET_NAME="shift-manager-env"
REGION="ap-south-1"
ENV_PATH="/var/www/shift-manager/.env"

SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_NAME" \
  --region "$REGION" \
  --query SecretString \
  --output text)

echo "$SECRET_JSON" | jq -r '
  to_entries | .[] | "\(.key)=\(.value)"
' > "$ENV_PATH"

chown ubuntu:ubuntu "$ENV_PATH"
chmod 600 "$ENV_PATH"

echo ".env file created"
