#!/usr/bin/dumb-init bashio
set -e

bashio::log.info "==> Starting application"

exec npm run dev