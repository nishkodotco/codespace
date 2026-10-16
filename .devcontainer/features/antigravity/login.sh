#!/usr/bin/env bash
set -euo pipefail

# agy only uses GEMINI_API_KEY when settings.json selects the gemini provider
SETTINGS="${HOME}/.gemini/antigravity-cli/settings.json"
if [[ -n "${GEMINI_API_KEY:-}" && ! -f "${SETTINGS}" ]]; then
    install -d -m 700 "$(dirname "${SETTINGS}")"
    echo '{ "modelProvider": "gemini" }' > "${SETTINGS}"
    chmod 600 "${SETTINGS}"
fi
