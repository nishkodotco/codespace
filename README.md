<h1 align="center">CODESPACE</h1>

<p align="center">
  A minimal UBI 9 dev container.
</p>

<p align="center">
  <code>nushell</code> · <code>neovim</code> · <code>gh</code> · <code>claude</code> · <code>codex</code> · <code>antigravity</code> · <code>ollama</code> · <code>node</code> · <code>python</code> · <code>latex</code>
</p>

---

Features live in [.devcontainer/features](.devcontainer/features). Toggle them in [devcontainer.json](.devcontainer/devcontainer.json) and rebuild.

`ollama` and `latex` are heavy, so they're opt-in. Install them in a running codespace when needed:

```sh
sudo bash .devcontainer/features/ollama/install.sh && nohup ollama serve > /tmp/ollama.log 2>&1 &
bash .devcontainer/features/latex/install.sh
```

> To stay signed in to `claude`, `codex` and `antigravity` after a rebuild, add your token as a [Codespaces secret](https://github.com/settings/codespaces).
