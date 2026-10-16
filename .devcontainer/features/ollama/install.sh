#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build
microdnf install -y tar gzip zstd findutils
microdnf clean all

# official installer; no systemd in the container, so it only drops the binary
curl -fsSL https://ollama.com/install.sh | sh

ollama --version || true
