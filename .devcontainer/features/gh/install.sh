#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build; skip if the base image already ships gh
if command -v gh >/dev/null 2>&1; then
    gh --version
    exit 0
fi

GH_TAG="$(curl -fsSL https://api.github.com/repos/cli/cli/releases/latest | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')"
GH_DIR="gh_${GH_TAG#v}_linux_amd64"
curl -fsSL -o "/tmp/${GH_DIR}.tar.gz" "https://github.com/cli/cli/releases/download/${GH_TAG}/${GH_DIR}.tar.gz"
tar -C /tmp -xzf "/tmp/${GH_DIR}.tar.gz"
install -m 755 "/tmp/${GH_DIR}/bin/gh" /usr/local/bin/gh
rm -rf "/tmp/${GH_DIR}" "/tmp/${GH_DIR}.tar.gz"

gh --version
