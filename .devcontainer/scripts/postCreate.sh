#!/usr/bin/env bash
set -euo pipefail

# Ensure ~/.local/bin is on PATH in this shell and future shells
export PATH="$HOME/.local/bin:$PATH"
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Install uv (idempotent)
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv --version

# Project structure
mkdir -p python jupyter typescript

# --- PYTHON subproject ---
cd python
[ -f pyproject.toml ] || uv init -q
uv venv .venv
printf 'print("Hello from python/test.py!")\n' > test.py
cd ..

# --- JUPYTER subproject ---
cd jupyter
[ -f pyproject.toml ] || uv init -q
uv venv .venv
source .venv/bin/activate
uv add -q jupyterlab ipykernel numpy pandas matplotlib
python -m ipykernel install --user --name jupyter-env --display-name "Python (jupyter-env)"
cat > test.ipynb <<'EOF'
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "print(\"Hello from jupyter/test.ipynb!\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python (jupyter-env)",
   "language": "python",
   "name": "jupyter-env"
  },
  "language_info": { "name": "python" }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF
cd ..

# --- TYPESCRIPT subproject ---
cd typescript
[ -f package.json ] || npm init -y --silent
npm i -D typescript ts-node @types/node --silent
npx -y tsc --init
npm pkg set scripts.start="ts-node test.ts"
printf 'console.log("Hello from typescript/test.ts!")\n' > test.ts