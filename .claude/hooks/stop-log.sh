#!/bin/bash
# Stop: タスク完了時に発火する
# matcherなし（応答完了の度に発火）

# ログファイルのパス
log_file="$CLAUDE_PROJECT_DIR/hooks.log"

# ログに記録
echo "$(date '+%Y-%m-%d %H:%M:%S'): Stopフックが発火しました" >> "$log_file"

exit 0
