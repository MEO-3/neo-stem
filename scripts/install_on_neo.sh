#!/usr/bin/env bash
# ==============================================================================
# NEO STEM Installer
# First-time installation script for NEO STEM interactive STEM education app.
# Handles ARM (Armbian/Raspberry Pi) and x86 platforms automatically.
#
# Usage:
#   Local:  bash scripts/install_on_neo.sh
#   Remote: curl -sSL https://raw.githubusercontent.com/MEO-3/neo-stem/master/scripts/install_on_neo.sh | bash
#
# Options:
#   --no-desktop   Skip .desktop file and icon installation
#   --no-venv      Install into system Python instead of a virtualenv
#   --uninstall    Remove NEO STEM installation
# ==============================================================================
set -euo pipefail

# -- Configuration ------------------------------------------------------------
APP_NAME="neo-stem"
DISPLAY_NAME="NEO STEM"
INSTALL_DIR="$HOME/.local/share/neo-stem"
VENV_DIR="$INSTALL_DIR/venv"
BIN_LINK="$HOME/.local/bin/neo-stem"
DESKTOP_FILE="$HOME/.local/share/applications/neo-stem.desktop"
ICON_DIR="$HOME/.local/share/icons/hicolor/128x128/apps"
ICON_FILE="$ICON_DIR/neo-stem.png"
PYPI_PACKAGE="neo-stem"
GITHUB_REPO="https://github.com/MEO-3/neo-stem.git"

# -- Parse arguments -----------------------------------------------------------
SKIP_DESKTOP=false
USE_VENV=false
UNINSTALL=false

for arg in "$@"; do
    case "$arg" in
        --no-desktop) SKIP_DESKTOP=true ;;
        --no-venv)    USE_VENV=false ;;
        --uninstall)  UNINSTALL=true ;;
        *)            echo "Unknown option: $arg"; exit 1 ;;
    esac
done

# -- Helpers -------------------------------------------------------------------
info()  { echo -e "\033[1;32m[INFO]\033[0m  $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

require_cmd() {
    if ! command -v "$1" &>/dev/null; then
        error "'$1' is required but not found. Please install it first."
        exit 1
    fi
}

detect_arch() {
    local machine
    machine="$(uname -m)"
    case "$machine" in
        aarch64|armv7l|armv6l) echo "arm" ;;
        x86_64|i686|i386)     echo "x86" ;;
        *)                    echo "unknown" ;;
    esac
}

# -- Uninstall -----------------------------------------------------------------
do_uninstall() {
    info "Uninstalling $DISPLAY_NAME..."

    if [ -d "$VENV_DIR" ]; then
        rm -rf "$VENV_DIR"
        info "Removed virtualenv: $VENV_DIR"
    fi

    if [ -L "$BIN_LINK" ]; then
        rm -f "$BIN_LINK"
        info "Removed symlink: $BIN_LINK"
    fi

    if [ -f "$DESKTOP_FILE" ]; then
        rm -f "$DESKTOP_FILE"
        update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
        info "Removed desktop entry: $DESKTOP_FILE"
    fi

    if [ -f "$ICON_FILE" ]; then
        rm -f "$ICON_FILE"
        info "Removed icon: $ICON_FILE"
    fi

    # Clean up install dir if empty
    rmdir "$INSTALL_DIR" 2>/dev/null || true

    info "$DISPLAY_NAME has been uninstalled."
    exit 0
}

if [ "$UNINSTALL" = true ]; then
    do_uninstall
fi

# -- Pre-flight checks ---------------------------------------------------------
ARCH="$(detect_arch)"
info "Detected architecture: $ARCH ($(uname -m))"

require_cmd python3

PYTHON_VERSION="$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
PYTHON_MAJOR="${PYTHON_VERSION%%.*}"
PYTHON_MINOR="${PYTHON_VERSION##*.}"

if [ "$PYTHON_MAJOR" -lt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]; }; then
    error "Python 3.8+ is required (found $PYTHON_VERSION)."
    exit 1
fi
info "Python $PYTHON_VERSION found."

# -- Step 1: Install system dependencies --------------------------------------
install_system_deps() {
    if [ "$ARCH" = "arm" ]; then
        info "ARM detected — installing Qt6 and PyQt6 system dependencies..."
        sudo apt-get update -qq
        sudo apt-get install -y -qq \
            python3-pyqt6 \
            qt6-qml-dev \
            qml6-module-qtquick \
            qml6-module-qtquick-controls \
            qml6-module-qtquick-layouts \
            qml6-module-qtquick-window \
            python3-venv \
            python3-pip \
            2>/dev/null || {
                warn "Some Qt6 packages not available via apt. Will try pip install."
            }
    elif [ "$ARCH" = "x86" ]; then
        info "x86 detected — PyQt6 will be installed via pip."
        if ! python3 -m venv --help &>/dev/null; then
            info "Installing python3-venv..."
            sudo apt-get update -qq
            sudo apt-get install -y -qq python3-venv
        fi
    else
        warn "Unknown architecture '$(uname -m)'. Proceeding with pip-based install."
    fi
}

install_system_deps

# -- Step 2: Create virtualenv and install -------------------------------------
install_in_venv() {
    mkdir -p "$INSTALL_DIR"

    if [ "$ARCH" = "arm" ]; then
        info "Creating virtualenv with system-site-packages (for apt PyQt6)..."
        python3 -m venv --system-site-packages "$VENV_DIR"
    else
        info "Creating isolated virtualenv..."
        python3 -m venv "$VENV_DIR"
    fi

    "$VENV_DIR/bin/pip" install --upgrade pip --quiet

    if [ "$ARCH" = "arm" ]; then
        # On ARM, PyQt6 may already be installed via apt
        # Install the app without pulling in PyQt6 from pip (avoid slow build)
        info "Installing $DISPLAY_NAME (--no-deps to use system PyQt6)..."
        "$VENV_DIR/bin/pip" install --quiet --no-deps "$PYPI_PACKAGE" 2>/dev/null || {
            info "PyPI package not found. Installing from GitHub source..."
            "$VENV_DIR/bin/pip" install --quiet --no-deps "git+${GITHUB_REPO}"
        }
    else
        info "Installing $DISPLAY_NAME and all dependencies..."
        "$VENV_DIR/bin/pip" install --quiet "$PYPI_PACKAGE" 2>/dev/null || {
            info "PyPI package not found. Installing from GitHub source..."
            "$VENV_DIR/bin/pip" install --quiet "git+${GITHUB_REPO}"
        }
    fi

    # Create bin symlink
    mkdir -p "$(dirname "$BIN_LINK")"
    ln -sf "$VENV_DIR/bin/neo-stem" "$BIN_LINK"
    info "Linked $BIN_LINK -> $VENV_DIR/bin/neo-stem"
}

install_without_venv() {
    local pip_args=()
    if python3 -m pip install --help 2>&1 | grep -q "break-system-packages"; then
        pip_args+=(--break-system-packages)
    fi

    if [ "$ARCH" = "arm" ]; then
        info "Installing $DISPLAY_NAME (--no-deps to use system PyQt6)..."
        python3 -m pip install "${pip_args[@]}" --quiet --no-deps "$PYPI_PACKAGE" 2>/dev/null || {
            info "PyPI package not found. Installing from GitHub source..."
            python3 -m pip install "${pip_args[@]}" --quiet --no-deps "git+${GITHUB_REPO}"
        }
    else
        info "Installing $DISPLAY_NAME and all dependencies..."
        python3 -m pip install "${pip_args[@]}" --quiet "$PYPI_PACKAGE" 2>/dev/null || {
            info "PyPI package not found. Installing from GitHub source..."
            python3 -m pip install "${pip_args[@]}" --quiet "git+${GITHUB_REPO}"
        }
    fi
}

if [ "$USE_VENV" = true ]; then
    install_in_venv
else
    install_without_venv
fi

# -- Step 3: Verify installation -----------------------------------------------
if [ "$USE_VENV" = true ]; then
    NEO_BIN="$VENV_DIR/bin/neo-stem"
else
    NEO_BIN="$(command -v neo-stem 2>/dev/null || true)"
fi

if [ -z "$NEO_BIN" ] || [ ! -x "$NEO_BIN" ]; then
    error "Installation verification failed — 'neo-stem' binary not found."
    exit 1
fi
info "Verified: $NEO_BIN"

# -- Step 4: Desktop integration -----------------------------------------------
install_desktop_entry() {
    if [ "$SKIP_DESKTOP" = true ]; then
        info "Skipping desktop integration (--no-desktop)."
        return
    fi

    local exec_path="$NEO_BIN"
    local icon_name="neo-stem"

    # Try to find icon from installed package
    local pkg_icon
    pkg_icon="$(python3 -c "
import importlib.resources, pathlib, sys
try:
    ref = importlib.resources.files('neo_stem') / 'assets' / 'neo-stem.png'
    with importlib.resources.as_file(ref) as p:
        print(p)
except Exception:
    pass
" 2>/dev/null || true)"

    if [ -n "$pkg_icon" ] && [ -f "$pkg_icon" ]; then
        mkdir -p "$ICON_DIR"
        cp "$pkg_icon" "$ICON_FILE"
        icon_name="$ICON_FILE"
        info "Installed icon: $ICON_FILE"
    fi

    mkdir -p "$(dirname "$DESKTOP_FILE")"
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=NEO STEM
GenericName=Interactive STEM Education
Comment=Ung dung giao duc STEM tuong tac cho hoc sinh Viet Nam (Lop 3-9)
Exec=$exec_path
Icon=$icon_name
Terminal=false
Categories=Education;Science;
Keywords=stem;education;science;vietnam;kids;
StartupNotify=true
EOF

    update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
    info "Created desktop entry: $DESKTOP_FILE"
}

install_desktop_entry

# -- Step 5: Ensure ~/.local/bin is in PATH ------------------------------------
ensure_path() {
    local bin_dir="$HOME/.local/bin"
    if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
        warn "$bin_dir is not in your PATH."

        local shell_rc=""
        case "$(basename "$SHELL")" in
            zsh)  shell_rc="$HOME/.zshrc" ;;
            bash) shell_rc="$HOME/.bashrc" ;;
            *)    shell_rc="$HOME/.profile" ;;
        esac

        if [ -f "$shell_rc" ] && ! grep -q 'local/bin' "$shell_rc"; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$shell_rc"
            info "Added $bin_dir to PATH in $shell_rc"
            info "Run 'source $shell_rc' or open a new terminal to use 'neo-stem'."
        fi
    fi
}

ensure_path

# -- Done ----------------------------------------------------------------------
echo ""
info "=========================================="
info "  $DISPLAY_NAME installed successfully!"
info "=========================================="
echo ""
echo "  Run:  neo-stem"
echo ""
if [ "$USE_VENV" = true ]; then
    echo "  Installed in: $VENV_DIR"
fi
echo "  Uninstall:    bash $0 --uninstall"
echo ""
