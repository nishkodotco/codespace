#!/usr/bin/env bash
set -euo pipefail

echo "=== Installing minimal dependencies ==="
sudo microdnf install -y \
    perl tar gzip wget xz findutils ca-certificates \
    && sudo microdnf clean all

echo "=== Installing TinyTeX ==="
TINYTEX="$HOME/.TinyTeX"

if [[ ! -x "$TINYTEX/bin/x86_64-linux/tlmgr" ]]; then
    echo "→ Installing TinyTeX ..."
    curl -sL "https://yihui.org/tinytex/install-bin-unix.sh" | sh
fi

echo "=== Setting PATH ==="
export PATH="$HOME/.TinyTeX/bin/x86_64-linux:$PATH"

# Just in case — fix ownership
chown -R "${_REMOTE_USER:-$(whoami)}:" "$HOME/.TinyTeX" 2>/dev/null || true

echo "=== Refreshing TeX database ==="
mktexlsr

echo "=== Updating tlmgr ==="
tlmgr update --self --quiet || true

echo "=== Installing your packages ==="
tlmgr install \
    amsmath amsfonts amssymb mathtools polynom soul \
    geometry xcolor float latexmk \
    || true

echo "=== Final refresh ==="
mktexlsr
updmap-sys --quiet || true

echo ""
echo "=== Quick verification ==="
echo -n "pdflatex: " && pdflatex --version | head -n1 || echo "not found"
echo -n "amsmath.sty: " && kpsewhich amsmath.sty || echo "missing"
echo -n "xcolor.sty: " && kpsewhich xcolor.sty || echo "missing"
echo ""
echo "If you see version + some .sty paths → LaTeX is working."