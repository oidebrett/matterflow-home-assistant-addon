#!/usr/bin/dumb-init bashio
# shellcheck shell=bash
set -e

bashio::log.info "==> Starting application"

exec serve -s dist
