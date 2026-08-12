#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Export Claude chat
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💬
# @raycast.packageName Claude
# @raycast.argument1 { "type": "dropdown", "placeholder": "Source", "data": [{ "title": "Claude Code", "value": "code" }, { "title": "Claude Desktop", "value": "desktop" }] }
# @raycast.argument2 { "type": "dropdown", "placeholder": "Which", "optional": true, "data": [{ "title": "Current chat", "value": "current" }, { "title": "Pick from list…", "value": "pick" }] }
# @raycast.argument3 { "type": "dropdown", "placeholder": "Detail", "optional": true, "data": [{ "title": "Conversation only", "value": "plain" }, { "title": "With thinking & tools", "value": "full" }] }

# Documentation:
# @raycast.author Arhun Saday
# @raycast.description Export a Claude Code session or Claude Desktop conversation to Markdown in ~/Downloads/claude-exports. Copies the file path to the clipboard.

set -euo pipefail

args=("${1}")
[ "${2:-current}" = "pick" ] && args+=(--pick)
[ "${3:-plain}" = "full" ] && args+=(--verbose)

exec "$HOME/.local/bin/claude-export" "${args[@]}"
