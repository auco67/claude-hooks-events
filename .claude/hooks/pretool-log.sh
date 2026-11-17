#!/bin/bash
# jq: choco install (Win)
# PreToolUse:ツール実行前に発火する
# matcher: "Bash" - Bashコマンド実行前に発火

# ログファイルのパス
log_file="$CLAUDE_PROJECT_DIR/hooks.log"

# stdinからJSONを読み取りコマンドを抽出する
input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

echo "$(date '+%Y-%m-%d %H:%M:%S'): PreToolUseフックが発火しました。コマンド: ${command}" >> "$log_file"

exit 0
