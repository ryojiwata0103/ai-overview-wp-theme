#!/bin/bash

# 新規GitHubリポジトリ作成スクリプト
# 使用方法: ./create-repo.sh <リポジトリ名> [説明]

if [ $# -eq 0 ]; then
    echo "使用方法: $0 <リポジトリ名> [説明]"
    echo "例: $0 my-new-project 'My awesome project'"
    exit 1
fi

REPO_NAME=$1
DESCRIPTION=${2:-""}

echo "🚀 新規リポジトリ「$REPO_NAME」を作成中..."

# テンポラリディレクトリでプロジェクトを初期化
TEMP_DIR="/tmp/$REPO_NAME"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# テンプレートファイルをコピー
cp -r /home/ryoji/github-template-repo/* ./
cp -r /home/ryoji/github-template-repo/.* ./ 2>/dev/null || true

# package.jsonのプロジェクト名を更新
if [ -f "package.json" ]; then
    sed -i "s/\"name\": \"project-template\"/\"name\": \"$REPO_NAME\"/" package.json
    if [ -n "$DESCRIPTION" ]; then
        sed -i "s/\"description\": \"プロジェクトテンプレート\"/\"description\": \"$DESCRIPTION\"/" package.json
    fi
fi

# READMEのプロジェクト名を更新
if [ -f "README.md" ]; then
    sed -i "1s/.*/# $REPO_NAME/" README.md
    if [ -n "$DESCRIPTION" ]; then
        sed -i "3s/.*/## 概要\n$DESCRIPTION/" README.md
    fi
fi

# Gitリポジトリを初期化
git init
git add .
git commit -m "feat: $REPO_NAME プロジェクトを初期化

- Claude Code GitHub Action設定済み
- TypeScript開発環境構築済み
- ESLint/Prettier設定済み
- PRテンプレート設定済み"

# GitHubリポジトリを作成
echo "📡 GitHubリポジトリを作成中..."
if [ -n "$DESCRIPTION" ]; then
    gh repo create "$REPO_NAME" --public --description "$DESCRIPTION" --source=.
else
    gh repo create "$REPO_NAME" --public --source=.
fi

# リモートにプッシュ
git push -u origin main

echo "✅ リポジトリ「$REPO_NAME」が正常に作成されました！"
echo "🔗 URL: https://github.com/$(gh api user --jq '.login')/$REPO_NAME"
echo ""
echo "📋 次の手順:"
echo "1. リポジトリ設定でCLAUDE_CODE_OAUTH_TOKENシークレットを設定"
echo "2. cd $(pwd) でプロジェクトディレクトリに移動"
echo "3. pnpm install で依存関係をインストール"
echo "4. .env.example を .env にコピーして環境変数を設定"