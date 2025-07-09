# python_package_template

A template repository for quickly creating and publishing a new Python package with best practices for structure, configuration, and distribution. This template includes automated setup, build, testing, and publishing workflows.

---

## Features

- Standard Python package layout
- Simple configuration via `pyproject.toml` and/or `setup.cfg`
- Reproducible builds and testing
- Linting, formatting, and CI/CD ready
- Automated initial setup with `configure.sh`

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/laugesen11/python_package_template.git
cd python_package_template
```

### 2. Run the Configuration Script

This repository includes a `configure.sh` script to help you quickly set up the package with your desired name and author information.  
**The script will:**
- Prompt you for your package name, author, description, etc.
- Update project files with your input
- Optionally, set up a fresh git history

**Run the script:**
```bash
./configure.sh
```
*If you get a permission denied error, make the script executable with:*
```bash
chmod +x configure.sh
```

### 3. Make and deploy the package

**This command will remove the .git directory and the configure.sh script**
```bash
make
```
---

## Setting Up Your Development Environment

It is recommended to use a virtual environment:

```bash
python -m venv .venv
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
```

Then install the package and dependencies:

```bash
pip install -U pip
pip install .[dev]
```
or, if provided:
```bash
pip install -r requirements.txt
```

---

## Configuration

- **Project Metadata**  
  Edit `pyproject.toml` or `setup.cfg` to update your package name, version, author, dependencies, etc.
- **Dependencies**  
  Add your runtime dependencies under `[project.dependencies]` in `pyproject.toml` or `install_requires` in `setup.cfg`.
- **Development Tools**  
  Development dependencies (test, lint, format) can be listed in `requirements-dev.txt` or as `[project.optional-dependencies]` in `pyproject.toml`.

---

## Building the Package

Build source and wheel distributions using [build](https://pypa-build.readthedocs.io/en/latest/):

```bash
pip install build
python -m build
```
Artifacts will be in the `dist/` directory.

---

## Running Tests

Tests are located in the `tests/` directory.  
Run tests with [pytest](https://docs.pytest.org/):

```bash
pip install pytest
pytest
```

---

## Linting and Formatting

Optionally use tools like `black`, `flake8`, or `ruff` for linting and formatting:

```bash
pip install black flake8
black .
flake8 .
```

---

## Publishing to PyPI

1. Register an account at [PyPI](https://pypi.org/).
2. Upload your built distributions using [twine](https://twine.readthedocs.io/):

```bash
pip install twine
twine upload dist/*
```

---

## Customization Tips

- Rename the main package directory from `python_package_template/` to your actual package name.
- Update all references in `pyproject.toml`, `setup.cfg`, and elsewhere.
- Add new dependencies and modules as your project grows.

---

## Contact

For questions or feedback, please open an issue or contact the maintainer.

