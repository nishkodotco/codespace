#!/usr/bin/env bash
set -eux

NVIM_TGZ="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/${NVIM_TGZ}"
cd /tmp
curl -fsSL -o "/tmp/${NVIM_TGZ}" "${NVIM_URL}"
rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf "/tmp/${NVIM_TGZ}"
rm -f "/tmp/${NVIM_TGZ}"
ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim || true
