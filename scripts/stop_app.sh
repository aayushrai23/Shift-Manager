#!/bin/bash
#!/bin/bash
set -e

cd /var/www/Shift-Manager || exit 0
docker compose down || true

