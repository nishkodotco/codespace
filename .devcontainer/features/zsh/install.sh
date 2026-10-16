#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build
microdnf update -y
microdnf install -y zsh util-linux-user
microdnf clean all

# set default shell to zsh for vscode user (default Codespaces user)
chsh -s /bin/zsh nishko

# empty .zshrc skips zsh-newuser-install, whose prompt blocks shell env probing
sudo -u nishko touch /home/nishko/.zshrc
