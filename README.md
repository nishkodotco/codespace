<h1 align="center">CODESPACE</h1>

<p align="center">
  A minimal UBI 9 dev container.
</p>

<p align="center">
  <code>nushell</code> · <code>neovim</code> · <code>gh</code> · <code>claude</code> · <code>codex</code> · <code>antigravity</code> · <code>ollama</code> · <code>node</code> · <code>python</code> · <code>latex</code>
</p>

---

Three configurations share the same dockerfile and features. Pick one under **Code → Codespaces → ⋯ → New with options**:

- [minimal](.devcontainer/minimal/devcontainer.json): `nushell` · `neovim` · `gh`
- [project](.devcontainer/project/devcontainer.json): minimal plus the AI CLIs (`claude` · `codex` · `antigravity`)
- [maximal](.devcontainer/maximal/devcontainer.json): every feature, including `ollama` and `latex` (slowest to build)

Features live in [.devcontainer/features](.devcontainer/features). Toggle them in either config and rebuild.
