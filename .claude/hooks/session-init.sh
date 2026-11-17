#!/usr/bin/env bash
# SessionStart フック:
#   package.json があり、node_modules がない場合に npm install を実行する

project_dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
package_json="$project_dir/package.json"
node_modules="$project_dir/node_modules"

echo "SessionStartフックが発火しました: $project_dir"

# package.json が無ければ何もしない
if [ ! -f "$package_json" ]; then
    echo "package.json が無いため npm install をスキップしました"
    exit 0
fi

# node_modules が既にあれば何もしない
if [ -d "$node_modules" ]; then
    echo "node_modules が既に存在するため npm install をスキップしました"
    exit 0
fi

echo "node_modules が無いため npm install を実行します"

# npm のログは標準エラーへ流す(標準出力は Claude のコンテキストに入るため)
(cd "$project_dir" && npm install) 1>&2
exit_code=$?

if [ "$exit_code" -ne 0 ]; then
    echo "npm install に失敗しました (exit code: $exit_code)" >&2
    exit 1
fi

echo "npm install が完了しました"
exit 0
