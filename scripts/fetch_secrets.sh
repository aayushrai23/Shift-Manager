#!/bin/bash
set -e

APP_DIR="/var/www/Shift-Manager"
BACKEND_ENV="$APP_DIR/backend/.env"
MONGO_ENV="$APP_DIR/mongo.env"

SECRET_NAME="shift-manager-env"
REGION="ap-south-1"

echo "Fetching backend secrets from AWS Secrets Manager..."

SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id "$SECRET_NAME" \
  --region "$REGION" \
  --query SecretString \
  --output text)

# Backend .env
mkdir -p "$APP_DIR/backend"

echo "$SECRET_JSON" | jq -r '
  to_entries | .[] | "\(.key)=\(.value)"
' > "$BACKEND_ENV"

# Mongo env (local, non-secret)
cat <<EOF > "$MONGO_ENV"
MONGO_INITDB_ROOT_USERNAME=admin
MONGO_INITDB_ROOT_PASSWORD=admin123
EOF

chown -R ubuntu:ubuntu "$APP_DIR"
chmod 600 "$BACKEND_ENV" "$MONGO_ENV"

echo "Environment files created successfully"
