#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# alacritty-opacity.sh - sets Alacritty opacity via `opacity.toml`.
#
# Usage: alacritty-opacity.sh <0.0-1.0>
# Example: alacritty-opacity.sh 0.85
# -----------------------------------------------------------------------------

# --- #!/usr/bin/env bash -----------------------------------------------------
# The shebang (#!) tells the kernel which interpreter runs this file.
# `#!/bin/bash` - hardcoded path (not always correct).
# `#!/usr/bin/env bash` - finds "bash" via $PATH.
# -----------------------------------------------------------------------------

# --- set -euo pipefail -------------------------------------------------------
#   -e : exit on any command failure
#   -u : error on unset variables
#   -o pipefail : fail pipeline if any command fails
# -----------------------------------------------------------------------------


set -euo pipefail


# --- file descriptors and redirects ------------------------------------------
# Every running process has numbered I/O channels called file descriptors (FDs):
#   0  stdin - where it reads input from
#   1  stdout - where it writes normal output
#   2  stderr - where it writes error messages
#
# The `>` operator redirects a stream to a file. By itself it redirects FD 1
# (stdout). Putting a number before it selects a different FD:
#   > file - redirect stdout (FD 1) to file - same as 1> file
#   2> file - redirect stderr (FD 2) to file - the 2 selects FD 2
#
# When the target is another FD instead of a file, you must prefix its number
# with `&` so bash doesn't interpret it as a filename:
#   >&2 - redirect stdout into FD 2 (stderr)
#   2>&1 - redirect FD 2 into wherever FD 1 currently points
#   Without `&`, `>2` would create a file literally named "2".
#
# The shorthand `&>` file redirects both stdout and stderr at once.
# It is equivalent to > file 2>&1.
#
# In this script `echo "..." >&2` sends error messages to stderr so they are
# visible to the user even when stdout is suppressed or captured.
# -----------------------------------------------------------------------------


CONFIG_DIR="$HOME/.config/alacritty"
OPACITY_FILE="$CONFIG_DIR/opacity.toml"


# `${0##*/}`: $0 is the full path the script was called with (e.g., /home/user/.local/bin/alacritty-opacity.sh).
# `##` strips the longest match of `*/` (anything up to and including the last slash).
# leaving only the filename: alacritty-opacity.sh
usage() {
    echo "Usage: ${0##*/} <0.0-1.0>" >&2
}


# `$#` is the number of arguments passed to the script.
if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi


OPACITY="$1"


# Validate that the value is a number in range [0.0, 1.0].
# Regex:
#   ^0(\.[0-9]+)?$ → matches 0, 0.5, 0.95, etc.
#   ^1(\.0+)?$ → matches 1, 1.0, 1.00, etc.
if ! [[ "$OPACITY" =~ ^0(\.[0-9]+)?$|^1(\.0+)?$ ]]; then
    echo "${0##*/}: invalid opacity '$OPACITY' - must be between 0.0 and 1.0" >&2
    usage
    exit 1
fi


# -p: create parent directories as needed, no error if already exists
mkdir -p "$CONFIG_DIR"

# Write the new opacity to the dedicated `opacity.toml` file.
# We write to a temp file first, then atomically move it into place.
tmpfile="$(mktemp)"
cat > "$tmpfile" <<TOML
[window]
opacity = $OPACITY
TOML
mv "$tmpfile" "$OPACITY_FILE"
echo "Opacity set to $OPACITY"


# Send a desktop notification if `notify-send` exists on this system.
# `command -v` checks for a command's existence without running it.
# &>/dev/null discards both its stdout and stderr — we only care whether
# it exits 0 (found) or non-zero (not found).
if command -v notify-send &>/dev/null; then
    notify-send "Alacritty" "Opacity changed to $OPACITY" -t 1000
fi
