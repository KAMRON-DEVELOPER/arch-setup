#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# alacritty-opacity.sh
# Sets Alacritty window opacity by writing to a separate opacity.toml file,
# then touching the main config to trigger live_config_reload.
#
# Usage: alacritty-opacity.sh <opacity>
# Example: alacritty-opacity.sh 0.85
#
# Bound to Alt+1..0 in keybindings.toml
# -----------------------------------------------------------------------------

# WHY #!/usr/bin/env bash INSTEAD OF #!/bin/bash:
#   /usr/bin/env searches your PATH for bash, making the script portable across
#   systems where bash might live in /usr/local/bin or elsewhere (e.g. macOS,
#   Nix, Homebrew). /bin/bash is hardcoded and may not exist on all systems.

# WHY set -euo pipefail:
#   Without these, bash silently ignores errors and keeps running — dangerous
#   in scripts that modify config files.
#
#   -e  (errexit)   : Exit immediately if any command returns a non-zero status.
#                     Prevents the script from continuing after a failed step.
#
#   -u  (nounset)   : Treat unset variables as errors. Without this, a typo like
#                     $OPACTY would silently expand to an empty string.
#
#   -o pipefail     : Without this, a pipeline like `cmd1 | cmd2` only checks
#                     cmd2's exit code. pipefail makes the whole pipeline fail
#                     if ANY command in it fails.
set -euo pipefail

# -----------------------------------------------------------------------------
# FILE DESCRIPTORS AND REDIRECTS — a brief explanation:
#
#   Every process has three standard file descriptors (FDs) open by default:
#     0  →  stdin  (input)
#     1  →  stdout (standard output)
#     2  →  stderr (error output)
#
#   Redirect operators:
#     >  file      : Redirect stdout (FD 1) to a file (overwrites)
#     >> file      : Redirect stdout to a file (appends)
#     2> file      : Redirect stderr (FD 2) to a file
#     2>&1         : Redirect FD 2 into whatever FD 1 currently points to
#     &> file      : Redirect both stdout and stderr to a file
#
#   In this script:
#     echo "..." >&2    →  sends error messages to stderr, not stdout.
#                          This is correct because callers (and Alacritty) may
#                          capture stdout, and errors should go to a separate
#                          stream so they don't pollute normal output.
# -----------------------------------------------------------------------------

CONFIG_DIR="$HOME/.config/alacritty"
OPACITY_FILE="$CONFIG_DIR/opacity.toml"


# ${0##*/} strips everything up to and including the last "/" from $0 (the
# script path), leaving just the filename. e.g. /home/user/.local/bin/alacritty-opacity.sh → alacritty-opacity.sh
usage() {
  echo "Usage: ${0##*/} <opacity>" >&2
  echo "  opacity: a number between 0.0 and 1.0" >&2
  echo "  Example: ${0##*/} 0.85" >&2
}


# `$#` is the number of arguments passed to the script.
if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi


OPACITY="$1"


# Validate that the value is a number in range [0.0, 1.0].
# Regex:
#   ^0(\.[0-9]+)?$   →  matches 0, 0.5, 0.95, etc.
#   ^1(\.0+)?$       →  matches 1, 1.0, 1.00, etc.
if ! [[ "$OPACITY" =~ ^0(\.[0-9]+)?$|^1(\.0+)?$ ]]; then
  echo "${0##*/}: invalid opacity '$OPACITY' — must be between 0.0 and 1.0" >&2
  usage
  exit 1
fi


# Ensure the config directory exists (-p: no error if already exists)
mkdir -p "$CONFIG_DIR"

# Write the new opacity to the dedicated `opacity.toml` file.
# We write to a temp file first, then atomically move it into place.
local tmpfile
tmpfile="$(mktemp)"
cat > "$tmpfile" <<TOML
[window]
opacity = $OPACITY
TOML
mv "$tmpfile" "$OPACITY_FILE"
echo "Opacity set to $OPACITY"


if command -v notify-send &>/dev/null; then
    notify-send "Alacritty" "Opacity changed to $OPACITY" -t 1000
fi
