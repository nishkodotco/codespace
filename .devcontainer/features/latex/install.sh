#!/usr/bin/env bash
set -euxo pipefail

# runs as root during build; install TinyTeX for the container user
USERNAME="${_REMOTE_USER:-nishko}"
USER_HOME="$(getent passwd "${USERNAME}" | cut -d: -f6)"

microdnf install -y perl tar gzip wget xz findutils ca-certificates
microdnf clean all

# root-run steps earlier in the build can leave these owned by root
install -d "${USER_HOME}/.cache" "${USER_HOME}/.config" "${USER_HOME}/.local/bin"
chown -R "${USERNAME}:${USERNAME}" "${USER_HOME}/.cache" "${USER_HOME}/.config" "${USER_HOME}/.local"

TL_BIN="${USER_HOME}/.TinyTeX/bin/x86_64-linux"
if [[ ! -x "${TL_BIN}/tlmgr" ]]; then
    sudo -u "${USERNAME}" -H bash -c 'curl -fsSL https://yihui.org/tinytex/install-bin-unix.sh | sh'
fi

sudo -u "${USERNAME}" -H "${TL_BIN}/tlmgr" update --self || true
sudo -u "${USERNAME}" -H "${TL_BIN}/tlmgr" install \
    amsmath amsfonts amssymb mathtools polynom soul \
    geometry xcolor float latexmk \
    || true
sudo -u "${USERNAME}" -H "${TL_BIN}/mktexlsr"
sudo -u "${USERNAME}" -H "${TL_BIN}/updmap-sys" --quiet || true

# put the TeX binaries on everyone's PATH
ln -sf "${TL_BIN}"/* /usr/local/bin/

sudo -u "${USERNAME}" -H pdflatex --version | head -n1
sudo -u "${USERNAME}" -H kpsewhich amsmath.sty xcolor.sty
