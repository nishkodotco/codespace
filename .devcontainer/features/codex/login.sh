#!/usr/bin/env bash
set -euo pipefail

# sign in from the OPENAI_API_KEY Codespaces secret when the volume has no sign-in yet
if [[ -n "${OPENAI_API_KEY:-}" ]] && ! codex login status >/dev/null 2>&1; then
    printenv OPENAI_API_KEY | codex login --with-api-key
fi
