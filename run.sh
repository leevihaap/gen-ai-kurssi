set -euo pipefail
cd "$(dirname "$0")"
 
from_windows() {
    (cd /mnt/c && powershell.exe -NoProfile -Command \
        "[Environment]::GetEnvironmentVariable('$1','User')") | tr -d '\r\n'
}
 
export CHAT_API_KEY="${CHAT_API_KEY:-$(from_windows CHAT_API_KEY)}"
export CHAT_MODEL="${CHAT_MODEL:-$(from_windows CHAT_MODEL)}"
export CHAT_BASE_URL="${CHAT_BASE_URL:-$(from_windows CHAT_BASE_URL)}"
: "${CHAT_BASE_URL:=https://generativelanguage.googleapis.com/v1beta/openai/}"
export CHAT_BASE_URL
 
# Jos ensimmäinen argumentti on .py-tiedosto, ajetaan se. Muuten ajetaan main.py.
if [[ "${1:-}" == *.py ]]; then
    script="$1"
    shift
else
    script="main.py"
fi
 
exec uv run --quiet "$script" "$@"
