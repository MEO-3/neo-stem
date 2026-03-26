# Building & Publishing NEO STEM to PyPI

## Prerequisites

```bash
pip install build twine
```

You also need a PyPI account. Register at https://pypi.org/account/register/

## 1. Build

From the project root:

```bash
python -m build
```

This creates two files in `dist/`:
- `neostem-1.0.0.tar.gz` (source distribution)
- `neostem-1.0.0-py3-none-any.whl` (wheel)

### Verify the build

Check that QML files are included:

```bash
python -c "
import zipfile
with zipfile.ZipFile('dist/neostem-1.0.0-py3-none-any.whl') as z:
    qml = [f for f in z.namelist() if '.qml' in f or 'qmldir' in f]
    print(f'QML files: {len(qml)}')
    print(f'Total files: {len(z.namelist())}')
"
```

Expected: 165 QML files, ~178 total files.

## 2. Test on TestPyPI (recommended first time)

Upload to the test index:

```bash
twine upload --repository testpypi dist/*
```

Install from TestPyPI to verify:

```bash
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ neostem
neostem
```

`--extra-index-url` is needed so PyQt6 resolves from the real PyPI.

## 3. Publish to PyPI

```bash
twine upload dist/*
```

Enter your PyPI username and password (or API token) when prompted.

### Using an API token (recommended)

Generate a token at https://pypi.org/manage/account/token/

```bash
twine upload dist/* -u __token__ -p pypi-YOUR_TOKEN_HERE
```

Or create `~/.pypirc`:

```ini
[pypi]
username = __token__
password = pypi-YOUR_TOKEN_HERE
```

Then just:

```bash
twine upload dist/*
```

## 4. Verify

```bash
pip install neostem
neostem
```

## Releasing a new version

1. Update `version` in `pyproject.toml`
2. Clean old builds: `rm -rf dist/ build/ *.egg-info`
3. Build: `python -m build`
4. Upload: `twine upload dist/*`

## What gets published

The wheel contains:
- `neo_stem/*.py` — app entry point and package init
- `neo_stem/backend/*.py` — Python QObject bridge (progress, badges)
- `neo_stem/data/*.py` — question/step constants
- `neo_stem/qml/**/*.qml` — all 143 QML UI files (core, menu, 20 activities)
- `neo_stem/qml/**/qmldir` — 22 QML module definition files

Controlled by `[tool.setuptools.package-data]` in `pyproject.toml`.
