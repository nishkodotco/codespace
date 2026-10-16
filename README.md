<h1 align="center">CODESPACE</h1>

A UBI 9 minimal dev container, defined in [.devcontainer/](.devcontainer/).

## Default features

| Feature | Installs |
| --- | --- |
| `zsh` | zsh, set as the login shell |
| `neovim` | latest Neovim release |

## Optional features

These live in [.devcontainer/features/](.devcontainer/features/) but are off by default. To enable one, add it to `features` in [devcontainer.json](.devcontainer/devcontainer.json) and rebuild:

```jsonc
"features": {
  "./features/zsh": {},
  "./features/neovim": {},
  "./features/claude": {}
}
```

| Feature | Installs | Notes |
| --- | --- | --- |
| `claude` | Claude Code (`claude`) | Sign-in persists, see below |
| `codex` | OpenAI Codex CLI (`codex`) | Sign-in persists, see below |
| `antigravity` | Antigravity CLI (`agy`) | Sign-in persists, see below |
| `ollama` | Ollama, server started on container start | Also add `"forwardPorts": [11434]` |
| `node` | Node.js v22.20.0 + npm | |
| `python` | Python 3 + pip | |
| `latex` | TinyTeX + common packages | Pairs with the `james-yu.latex-workshop` extension |

## Keeping AI tools signed in

Each AI feature keeps its config folder on a Docker volume, so a normal **Rebuild Container** keeps you signed in. A **Full Rebuild** or deleting the codespace wipes volumes. For those cases, add a [Codespaces secret](https://github.com/settings/codespaces) scoped to this repo, and the tool signs itself back in on start:

| Tool | Volume | Secret | How to get it |
| --- | --- | --- | --- |
| Claude Code | `~/.claude` | `CLAUDE_CODE_OAUTH_TOKEN` (subscription) or `ANTHROPIC_API_KEY` | Run `claude setup-token` |
| Codex | `~/.codex` | `OPENAI_API_KEY` | OpenAI API key; for a ChatGPT plan, run `codex login --device-auth` once instead |
| Antigravity | `~/.gemini` | `GEMINI_API_KEY` | Gemini API key; or run `agy` and sign in with Google once |

Secrets are encrypted by GitHub and only exposed to codespaces of the repos you pick. Never commit tokens to this repo.
