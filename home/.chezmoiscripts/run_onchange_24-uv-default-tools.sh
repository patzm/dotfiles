#! /usr/bin/env bash

set -euo pipefail

REQ_FILE="${HOME}/.config/python-venv/requirements.txt"

if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found in PATH. Skipping uv default tool installation."
    exit 0
fi

if [ ! -f "$REQ_FILE" ]; then
    echo "Requirements file not found: $REQ_FILE. Skipping uv default tool installation."
    exit 0
fi

while IFS= read -r line || [ -n "$line" ]; do
    pkg=$(printf '%s' "$line" | sed 's/[[:space:]]*#.*$//' | tr -d '\r')
    [ -z "$pkg" ] && continue

    echo "Installing/upgrading uv tool: $pkg"
    uv tool install --upgrade "$pkg"
done < "$REQ_FILE"

echo "uv default tool installation complete."
