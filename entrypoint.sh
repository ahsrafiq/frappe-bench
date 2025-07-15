#!/bin/bash

echo "🔧 Creating common_site_config.json from ENV..."
cat <<EOF > sites/common_site_config.json
{
  "db_type": "${DB_TYPE}",
  "db_host": "${DB_HOST}",
  "db_port": ${DB_PORT},
  "db_name": "${DB_NAME}",
  "db_password": "${DB_PASSWORD}",
  "redis_cache": "${REDIS_CACHE}",
  "redis_queue": "${REDIS_QUEUE}",
  "redis_socketio": "${REDIS_SOCKETIO}",
  "use_redis_auth": ${USE_REDIS_AUTH},
  "webserver_port": ${WEB_SERVER_PORT},
  "socketio_port": ${SOCKETIO_PORT}
}
EOF

echo "✅ common_site_config.json created."

set -e

echo "🔧 Setting up requirements..."
bench setup requirements || true

echo "🔧 Building production assets..."
bench build --production || true

echo "🚀 Starting bench..."
exec bench start

