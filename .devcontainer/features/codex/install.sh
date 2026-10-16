#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build
USERNAME="${_REMOTE_USER:-nishko}"
USER_HOME="$(getent passwd "${USERNAME}" | cut -d: -f6)"

# volume mount point; a fresh volume copies this owner and mode
install -d -m 700 -o "${USERNAME}" -g "${USERNAME}" "${USER_HOME}/.codex"

CODEX_TGZ="codex-x86_64-unknown-linux-musl.tar.gz"
curl -fsSL -o "/tmp/${CODEX_TGZ}" "https://github.com/openai/codex/releases/latest/download/${CODEX_TGZ}"
tar -C /tmp -xzf "/tmp/${CODEX_TGZ}"
install -m 755 /tmp/codex-x86_64-unknown-linux-musl /usr/local/bin/codex
rm -f "/tmp/${CODEX_TGZ}" /tmp/codex-x86_64-unknown-linux-musl

install -D -m 755 "$(dirname "$0")/login.sh" /usr/local/share/codex/login.sh

sudo -u "${USERNAME}" -H codex --version
