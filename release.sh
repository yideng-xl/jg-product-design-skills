#!/usr/bin/env bash
#
# release.sh — 一条命令发布本插件的新版本
#
# 用法:
#   ./release.sh <版本号> [提交说明]
#   例:./release.sh 1.10.0 "requirements2prd 增加 xxx"
#
# 它会自动:
#   1. 校验版本号格式(X.Y.Z)
#   2. 拒绝重复 tag(新版本必须用新 tag,杜绝空壳 tag / 移动 tag)
#   3. 要求 CHANGELOG.md 已写好本版本条目(不替你瞎编变更内容)
#   4. 把 plugin.json + marketplace.json 的所有 version 字段同步成新版本
#   5. git add -A 后展示全部改动并让你确认(确保 skill 内容不会漏提交)
#   6. 提交 → 在该 commit 上打 tag → push main + tag
#
set -euo pipefail

VERSION="${1:-}"
MSG="${2:-release}"

# 1. 版本号格式校验
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ 版本号格式错误,应为 X.Y.Z。例:./release.sh 1.10.0 \"变更说明\""
  exit 1
fi

# 定位到脚本所在目录(=插件仓库根)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

PLUGIN_JSON=".claude-plugin/plugin.json"
MARKET_JSON=".claude-plugin/marketplace.json"
CHANGELOG="CHANGELOG.md"

for f in "$PLUGIN_JSON" "$MARKET_JSON" "$CHANGELOG"; do
  [[ -f "$f" ]] || { echo "❌ 找不到 $f,请确认在插件仓库根目录运行。"; exit 1; }
done

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
TAG="v$VERSION"

# 2. tag 不能已存在(本地 + 远端都查)
if git rev-parse -q --verify "refs/tags/$TAG" >/dev/null; then
  echo "❌ 本地已存在 tag $TAG。新版本请用新版本号;确需重发请先手动删除旧 tag。"
  exit 1
fi
if git ls-remote --tags origin "$TAG" 2>/dev/null | grep -q "refs/tags/$TAG"; then
  echo "❌ 远端已存在 tag $TAG。"
  exit 1
fi

# 3. CHANGELOG 必须有本版本条目
if ! grep -q "## \[$VERSION\]" "$CHANGELOG"; then
  echo "❌ CHANGELOG.md 里没有 '## [$VERSION]' 条目。"
  echo "   请先在 CHANGELOG 顶部写好本版本变更说明,再运行发布。"
  exit 1
fi

# 4. 同步写入版本号(两个 json 里所有 "version" 字段)
perl -i -pe 's/("version"\s*:\s*")[^"]*(")/${1}'"$VERSION"'${2}/g' "$PLUGIN_JSON"
perl -i -pe 's/("version"\s*:\s*")[^"]*(")/${1}'"$VERSION"'${2}/g' "$MARKET_JSON"
echo "✅ 版本号已同步为 $VERSION:"
grep -H '"version"' "$PLUGIN_JSON" "$MARKET_JSON" | sed 's/^/   /'

# 5. 暂存全部改动并展示,确认后再提交
echo
echo "===== 将要提交的改动(含 skill 内容)====="
git add -A
git status --short | sed 's/^/   /'
echo
read -r -p "确认提交并发布 $TAG 到 origin/$BRANCH ?(y/N) " ans
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
  echo "已取消。改动已 stage 但未提交(可用 git restore --staged . 撤销)。"
  exit 0
fi

# 6. 提交 → 打 tag → 推送
git commit -m "$VERSION: $MSG"
git tag -a "$TAG" -m "$TAG"
git push origin "$BRANCH"
git push origin "$TAG"

echo
echo "🎉 $TAG 发布完成"
echo "   commit:        $(git rev-parse --short HEAD)"
echo "   远端分支:      origin/$BRANCH"
echo "   同事侧更新方式:Cowork 插件菜单 ⋮ → Check for updates"
echo "                  (或开启 Sync automatically,几分钟内自动拉取,无需删除重装)"
