#!/bin/bash
set -e

REPO_NAME="industry-sales-toolkit"

echo "=== 影刀 RPA 行业销售工具包 - 部署脚本 ==="
echo ""

# Check git config
if ! git config user.name &>/dev/null; then
    read -p "输入你的名字: " GIT_NAME
    git config user.name "$GIT_NAME"
fi
if ! git config user.email &>/dev/null; then
    read -p "输入你的邮箱: " GIT_EMAIL
    git config user.email "$GIT_EMAIL"
fi

# Get GitHub username
if [ -z "$GITHUB_USER" ]; then
    read -p "输入你的 GitHub 用户名: " GITHUB_USER
fi

REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

# Check if remote already exists
if git remote get-url origin &>/dev/null; then
    CURRENT=$(git remote get-url origin)
    if [ "$CURRENT" != "$REMOTE_URL" ]; then
        git remote set-url origin "$REMOTE_URL"
    fi
else
    git remote add origin "$REMOTE_URL"
fi

echo ""
echo "推送代码到 GitHub..."
git push -u origin main 2>&1

echo ""
echo "=================================="
echo "部署完成！"
echo ""
echo "请完成最后一步 — 启用 GitHub Pages："
echo ""
echo "1. 打开: https://github.com/${GITHUB_USER}/${REPO_NAME}/settings/pages"
echo "2. Source 选择 'Deploy from a branch'"
echo "3. Branch 选择 'main'，目录选 '/ (root)'"
echo "4. 点击 Save"
echo ""
echo "等待 1 分钟后，公开访问地址："
echo "https://${GITHUB_USER}.github.io/${REPO_NAME}/"
echo ""
echo "把这个链接发给销售，直接浏览器打开即可！"
echo "=================================="
