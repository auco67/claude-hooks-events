#!/bin/bash
# 要jq: sudo apt install jq
# PostToolUse: ツール実行後に発火する
# matcher: "Write|Edit" - ファイル作成/編集時に発火
# 作成・編集されたファイルをPrettierでフォーマットする

# ログファイルのパス
log_file="$CLAUDE_PROJECT_DIR/hooks.log"

# stdinからJSONを読み取り、対象ファイルのパスを抽出する
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

echo "$(date '+%Y-%m-%d %H:%M:%S'): PostToolUseフックが発火しました。ファイル: ${file_path}" >> "$log_file"

# ファイルパスが取得できない、またはファイルが存在しない場合は何もしない
if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
  exit 0
fi

# プロジェクトローカルのPrettierを使用する
# (.bin/prettier は実行権限が無い環境があるため、nodeで本体を直接実行する)
prettier="$CLAUDE_PROJECT_DIR/node_modules/prettier/bin/prettier.cjs"
if ! command -v node > /dev/null 2>&1 || [ ! -f "$prettier" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Prettierが見つからないためフォーマットをスキップしました" >> "$log_file"
  exit 0
fi

# Prettierでフォーマット(設定は .prettierrc に従う)
# --ignore-unknown: Prettier非対応の拡張子(.sh など)はエラーにせずスキップする
if output=$(cd "$CLAUDE_PROJECT_DIR" && node "$prettier" --write --ignore-unknown "$file_path" 2>&1); then
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Prettierでフォーマットしました: ${file_path}" >> "$log_file"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S'): Prettierのフォーマットに失敗しました: ${file_path} ${output}" >> "$log_file"
fi

exit 0
