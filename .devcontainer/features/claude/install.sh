#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build; install for the container user
USERNAME="${_REMOTE_USER:-nishko}"
USER_HOME="$(getent passwd "${USERNAME}" | cut -d: -f6)"

# volume mount point; a fresh volume copies this owner and mode
install -d -m 700 -o "${USERNAME}" -g "${USERNAME}" "${USER_HOME}/.claude"

sudo -u "${USERNAME}" -H bash -c 'curl -fsSL https://claude.ai/install.sh | bash'
ln -sf "${USER_HOME}/.local/bin/claude" /usr/local/bin/claude

# sign-in comes from the volume, or from the CLAUDE_CODE_OAUTH_TOKEN /
# ANTHROPIC_API_KEY Codespaces secret, which claude reads directly
sudo -u "${USERNAME}" -H claude --version
