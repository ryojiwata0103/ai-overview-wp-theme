# 3システム統合ガイド

プロジェクトで利用可能な3つのAI開発支援システムの統合運用ガイドです。

## 🎯 システム概要

### 1. Claude Code Action（必須）
- **用途**: GitHub上でのリアルタイムAI支援
- **トリガー**: `@claude` メンション
- **設定ファイル**: `.github/workflows/claude.yml`
- **適用場面**: PR・Issue・コードレビュー

### 2. CI/CD自動化（推奨）
- **用途**: コード品質・テスト・セキュリティの継続的チェック
- **トリガー**: `push`, `pull_request`, 手動実行
- **設定ファイル**: `.github/workflows/ci-basic.yml`
- **適用場面**: 品質保証・デプロイ準備

### 3. SuperClaude（オプション）
- **用途**: ローカル開発での構造化AI支援
- **トリガー**: ローカルでのclaude実行
- **設定ファイル**: `.claude/CLAUDE.md`
- **適用場面**: アーキテクチャ設計・分析・高度な開発支援

## 🔄 統合ワークフロー

```mermaid
graph TD
    A[新機能開発開始] --> B{開発段階}
    
    B -->|1. 設計段階| C[SuperClaude]
    C --> C1[/sc:analyze --focus architecture]
    C1 --> C2[設計ドキュメント生成]
    
    B -->|2. 実装段階| D[通常の開発作業]
    D --> E[GitHub PR作成]
    E --> F[@claude でコードレビュー]
    
    B -->|3. 統合段階| G[CI/CDパイプライン実行]
    G --> G1[品質チェック]
    G1 --> G2[セキュリティスキャン]
    G2 --> G3[テスト実行]
    
    C2 --> H[claude.md更新]
    F --> H
    G3 --> H
    
    H --> I[統合完了・デプロイ準備]
```

## 📋 段階別使い分けガイド

### Phase 1: プロジェクト初期化
```bash
# 1. SuperClaudeでプロジェクト分析（オプション）
claude /sc:analyze . --type structure --depth comprehensive

# 2. 基本設定の確認
git status
cat claude.md

# 3. CI/CDパイプラインのテスト
git add .
git commit -m "feat: initialize project structure"
git push # CI/CDが自動実行される
```

### Phase 2: 機能開発
```bash
# 1. 新しいブランチで開発開始
git checkout -b feature/new-functionality

# 2. SuperClaudeで設計支援（オプション）
claude --agent system-architect "新機能のアーキテクチャ設計"

# 3. 実装作業
# ... coding ...

# 4. プルリクエスト作成
git push -u origin feature/new-functionality
gh pr create --title "feat: add new functionality"

# 5. Claude Code Actionでレビュー
# PR内で @claude "この実装についてレビューしてください"
```

### Phase 3: 品質保証
```bash
# 1. CI/CDパイプラインの結果確認
gh pr checks

# 2. 問題があればSuperClaudeで分析（オプション）
claude /sc:troubleshoot "CI/CDエラーの解決"

# 3. claude.md更新
# 学習事項や重要な決定事項を記録

# 4. 最終チェックとマージ
gh pr merge --squash
```

## ⚙️ 設定カスタマイズ

### Claude Code Actionのカスタマイズ
`.github/workflows/claude.yml`で以下をカスタマイズ可能：

```yaml
# カスタム指示の追加
custom_instructions: |
  - TypeScriptのみを使用
  - テストカバレッジ80%以上を維持
  - claude.mdの更新を忘れずに

# 許可するツール
allowed_tools: "Bash(npm install),Bash(npm run build),Bash(npm run test)"

# モデル選択（デフォルト: Claude Sonnet 4）
model: "claude-opus-4-1-20250805"  # より高性能なモデル
```

### CI/CDパイプラインのカスタマイズ
`.github/workflows/ci-basic.yml`で調整：

```yaml
# Node.jsバージョンの変更
NODE_VERSION: '22'

# 追加のテストスイート
- name: E2E Tests
  run: pnpm run test:e2e

# デプロイ環境の設定
- name: Deploy to Staging
  if: github.ref == 'refs/heads/develop'
  run: pnpm run deploy:staging
```

## 🚨 トラブルシューティング

### よくある問題と解決方法

#### 1. Claude Code Actionが反応しない
```bash
# シークレット設定を確認
gh secret list

# ワークフローの状態確認
gh workflow list
gh workflow view claude.yml
```

#### 2. CI/CDパイプラインが失敗する
```bash
# ログの詳細確認
gh run list --workflow=ci-basic.yml
gh run view <run-id> --log

# ローカルでの再現テスト
pnpm install
pnpm run build
pnpm test
```

#### 3. SuperClaude統合エラー
```bash
# SuperClaudeの状態確認
claude --version
claude config list

# プロジェクト設定の再初期化
./scripts/setup-integration.sh
```

## 📊 効果測定

### 統合による改善指標
- **開発速度**: PR作成からマージまでの時間短縮
- **品質向上**: バグ発見率の改善、テストカバレッジ向上
- **知識共有**: claude.mdによる開発履歴の蓄積
- **自動化効果**: 手動チェック作業の削減

### 月次レビュー項目
1. CI/CDパイプラインの成功率
2. Claude Code Actionの利用頻度と効果
3. claude.mdの更新頻度と品質
4. SuperClaude活用による設計品質改善

## 🎯 まとめ

この統合環境により以下を実現：

1. **効率的な開発**: 適切なツールの使い分けによる作業効率化
2. **高品質なコード**: 多層的な品質チェック機構
3. **継続的な改善**: 自動化とAI支援による持続的な品質向上
4. **知識の蓄積**: claude.mdによる組織的学習の促進

各システムの特性を理解し、開発段階に応じて適切に活用することで、最大の効果を得られます。