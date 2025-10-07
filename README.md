# AI Dev Container

This repo contains a dev container configuration that will create the following:

python/

- pyproject.toml (from uv init)
- .venv/ (from uv venv)
- test.py → Hello from python/test.py!

jupyter/

- pyproject.toml (from uv init)
- .venv/ with jupyterlab, ipykernel, numpy, pandas, matplotlib
- Jupyter kernel registered as Python (jupyter-env)
- test.ipynb (one cell printing a hello)

typescript/

- package.json (with "start": "ts-node test.ts")
- tsconfig.json
- dev deps: typescript, ts-node, @types/node
- test.ts → logs a hello

## Usage

### Python

```zsh
cd python
. .venv/bin/activate
python test.py
```

### Jupyter

```zsh
cd jupyter
. .venv/bin/activate
jupyter lab
```

Then open `test.ipynb` and run the cell.

### TypeScript

```zsh
cd typescript
npm run
```
