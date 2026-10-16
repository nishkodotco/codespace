#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build
NU_TAG="$(curl -fsSL https://api.github.com/repos/nushell/nushell/releases/latest | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')"
NU_DIR="nu-${NU_TAG}-x86_64-unknown-linux-musl"
curl -fsSL -o "/tmp/${NU_DIR}.tar.gz" "https://github.com/nushell/nushell/releases/download/${NU_TAG}/${NU_DIR}.tar.gz"
tar -C /tmp -xzf "/tmp/${NU_DIR}.tar.gz"
install -m 755 /tmp/${NU_DIR}/nu* /usr/local/bin/
rm -rf "/tmp/${NU_DIR}" "/tmp/${NU_DIR}.tar.gz"
grep -qx /usr/local/bin/nu /etc/shells || echo /usr/local/bin/nu >> /etc/shells

# prompt
curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b /usr/local/bin

# login shell stays bash: VS Code's env probe and Claude Code need a POSIX shell
nu --version
starship --version
