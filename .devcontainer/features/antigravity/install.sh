#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build; install for the container user
USERNAME="${_REMOTE_USER:-nishko}"
USER_HOME="$(getent passwd "${USERNAME}" | cut -d: -f6)"

# volume mount point; a fresh volume copies this owner and mode
install -d -m 700 -o "${USERNAME}" -g "${USERNAME}" "${USER_HOME}/.gemini"

sudo -u "${USERNAME}" -H bash -c 'curl -fsSL https://antigravity.google/cli/install.sh | bash'
ln -sf "${USER_HOME}/.local/bin/agy" /usr/local/bin/agy

install -D -m 755 "$(dirname "$0")/login.sh" /usr/local/share/antigravity/login.sh

sudo -u "${USERNAME}" -H /usr/local/bin/agy --version
