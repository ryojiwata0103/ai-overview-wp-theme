# 🚀 統合開発環境ガイド

GitHub Project Templateの統合開発環境の完全ガイドです。

## 🎯 概要

このテンプレートは、3つのAI支援システムを統合した高度な開発環境を提供します：

1. **Claude Code Action** - GitHub上でのリアルタイムAI支援
2. **CI/CD自動化** - 品質・セキュリティ・パフォーマンスの継続的検証
3. **SuperClaude** - ローカル開発での構造化AI支援（オプション）

## 🚀 クイックスタート

### 1. テンプレートの利用

```bash
# このテンプレートを使用してプロジェクト作成
gh repo create my-awesome-project --template ryojiwata0103/github-project-template --public
cd my-awesome-project

# または既存プロジェクトに適用
git clone https://github.com/ryojiwata0103/github-project-template.git temp-template
cp -r temp-template/.github temp-template/.claude temp-template/scripts temp-template/docs ./
rm -rf temp-template
```

### 2. 統合環境のセットアップ

```bash
# 対話式セットアップを実行
./scripts/setup-integration.sh

# 基本CI/CDのみの場合（推奨）
./scripts/setup-integration.sh
# 選択: 1 (basic)

# 完全統合の場合
./scripts/setup-integration.sh  
# 選択: 4 (full)
```

### 3. GitHub Secrets設定

GitHub リポジトリで以下のSecretを設定：

```
Settings > Secrets and variables > Actions > New repository secret
```

- **CLAUDE_CODE_OAUTH_TOKEN**: Claude Code用OAuthトークン
  - 取得方法: https://claude.ai/settings で生成

### 4. 初回テスト

```bash
# CI/CDパイプラインのテスト
git add .
git commit -m "feat: initialize integrated development environment"
git push

# プルリクエストでClaude Code Actionをテスト
git checkout -b feature/test-integration
echo "# Test" > test.md
git add test.md
git commit -m "feat: add test file"  
git push -u origin feature/test-integration
gh pr create --title "feat: test integrated environment"

# PR内で @claude "この統合環境について説明してください"
```

## 📚 システム別詳細ガイド

### 🔧 CI/CD自動化パイプライン

#### 基本パイプライン（ci-basic.yml）
自動実行される品質チェック：

- **TypeScript コンパイル**: 型エラーの検出
- **テスト実行**: 単体テスト・カバレッジ測定
- **ESLint・Prettier**: コード品質・フォーマット
- **セキュリティ監査**: 依存関係の脆弱性チェック
- **ビルド検証**: 複数Node.jsバージョンでのビルド
- **claude.md更新確認**: ドキュメント更新の推奨

#### 高度なパイプライン（ci-advanced.yml）
オプションで有効化できる追加機能：

- **CodeQL分析**: 高度なセキュリティスキャン
- **OWASP Dependency Check**: 包括的な脆弱性評価
- **パフォーマンステスト**: バンドルサイズ・ビルド時間測定
- **クロスプラットフォーム**: Windows・macOS・Linux検証
- **自動デプロイ準備**: 本番環境向け準備処理

#### カスタマイズ方法

```yaml
# .github/workflows/ci-basic.yml
env:
  NODE_VERSION: '20'  # Node.jsバージョン変更
  PNPM_VERSION: '9'   # pnpmバージョン変更

# 追加テストの例
- name: E2E Tests
  run: pnpm run test:e2e
  
- name: Visual Regression Tests  
  run: pnpm run test:visual
```

### 🤖 Claude Code Action

#### 基本的な使用方法

```bash
# Issue・PR・コメントで @claude を使用
@claude この実装についてレビューしてください
@claude パフォーマンスを改善する提案をお願いします
@claude セキュリティ上の問題はありますか？
@claude この機能のテストケースを考えてください
```

#### 高度な活用例

```bash
# 具体的な指示
@claude この関数をTypeScriptで型安全に書き直してください

# 技術的な質問
@claude この実装でメモリリークは発生しませんか？

# コードレビュー
@claude このPRの変更点を要約し、潜在的な問題があれば指摘してください

# 設計相談
@claude この新機能に最適なアーキテクチャパターンを提案してください
```

#### カスタム設定

```yaml
# .github/workflows/claude.yml
with:
  # プロジェクト固有の指示
  custom_instructions: |
    - TypeScriptのstrictモードを維持
    - テストカバレッジ80%以上を保持
    - claude.md更新を忘れずに確認
    - セキュリティ第一の実装を心がける
  
  # 使用可能なコマンド制限
  allowed_tools: |
    Bash(pnpm install)
    Bash(pnpm run build)
    Bash(pnpm run test:*)
    Bash(pnpm run lint:*)
  
  # 高性能モデル使用
  model: "claude-opus-4-1-20250805"
```

### 🧠 SuperClaude統合（オプション）

#### インストールと設定

```bash
# SuperClaudeインストール
curl -sSL https://get.superclaude.com | bash

# プロジェクト設定
claude config set project.name "my-project"
claude config set project.type "typescript"  
claude config set project.framework "react" # 必要に応じて
```

#### 主要コマンド

```bash
# プロジェクト分析
claude /sc:analyze . --type structure --depth comprehensive

# アーキテクチャ設計
claude --agent system-architect "新機能のアーキテクチャ提案"

# コード品質向上
claude --agent refactoring-expert "技術的負債の解消提案"

# セキュリティチェック
claude --agent security-engineer "脆弱性分析と対策提案"

# パフォーマンス最適化
claude --agent performance-engineer "ボトルネック分析"
```

#### 開発ワークフローへの統合

```bash
# 新機能開発の流れ
git checkout -b feature/new-functionality

# 1. アーキテクチャ設計
claude /sc:design --persona system-architect --focus "新機能のアーキテクチャ"

# 2. 実装ガイダンス  
claude /sc:implement --agent frontend-architect --task "UI コンポーネント実装"

# 3. 品質チェック
claude /sc:review --agent quality-engineer --target "実装完了したコード"

# 4. 最終検証
claude /sc:validate --production-ready
```

## 🔄 実践的ワークフロー例

### 新機能開発の完全フロー

```bash
# === Phase 1: 計画・設計 ===
# SuperClaudeで要件分析（オプション）
claude /sc:analyze requirements.md --persona requirements-analyst

# 設計ドキュメント作成
claude /sc:design --output-format markdown > design.md

# === Phase 2: 実装開始 ===
git checkout -b feature/user-authentication
git add design.md
git commit -m "docs: add authentication feature design"

# 実装作業...
# ... coding ...

# === Phase 3: レビュー・品質保証 ===
# プルリクエスト作成
git push -u origin feature/user-authentication
gh pr create --title "feat: implement user authentication system"

# CI/CDパイプライン自動実行（品質チェック）
# 結果確認: gh pr checks

# Claude Code Actionでレビュー
# PR内で: @claude "この認証システムの実装をレビューしてください。セキュリティ面で注意点はありますか？"

# === Phase 4: 改善・デプロイ ===
# フィードバック対応後
git add .
git commit -m "fix: address security and performance feedback"
git push

# 最終確認とマージ
gh pr merge --squash

# claude.md更新（重要な学習事項・決定事項を記録）
# 例: 認証ライブラリの選択理由、セキュリティ要件、パフォーマンス考慮事項
```

### トラブルシューティングフロー

```bash
# CI/CDパイプラインが失敗した場合
gh run list --workflow=ci-basic.yml
gh run view <run-id> --log

# SuperClaudeでエラー分析（オプション）
claude /sc:troubleshoot "CI/CD failure analysis" --log-file ci-error.log

# Claude Code Actionで解決策相談
# Issue作成: @claude "CI/CDパイプラインでTypeScriptエラーが発生しています。解決方法を教えてください。"
```

## 📊 効果測定と改善

### KPI指標

**開発効率**
- PRのマージまでの時間
- コードレビューの品質向上
- バグ修正時間の短縮

**コード品質**  
- テストカバレッジ（目標：80%以上）
- ESLintエラー数の削減
- セキュリティ脆弱性の早期発見数

**チーム学習**
- claude.md更新頻度
- AI支援ツール利用率
- 技術的負債削減率

### 継続的改善

```bash
# 月次レビュー用スクリプト（例）
# パフォーマンス分析
gh run list --workflow=ci-basic.yml --limit=30 --json conclusion | jq '.[] | select(.conclusion=="success") | length'

# claude.md更新頻度
git log --since="1 month ago" --oneline -- claude.md | wc -l

# AI支援活用状況
gh api repos/:owner/:repo/issues/comments | jq '[.[] | select(.body | contains("@claude"))] | length'
```

## 🎯 ベストプラクティス

### DO ✅
- **段階的導入**: まずはbasicから始めて徐々に拡張
- **claude.md活用**: 重要な決定事項・学習を必ず記録
- **適切なツール選択**: 各段階で最適なツールを使い分け
- **継続的改善**: 定期的な設定見直しとカスタマイズ
- **セキュリティファースト**: 常にセキュリティを最優先に考慮

### DON'T ❌
- **過度の複雑化**: 必要以上に高度な機能を有効にしない
- **設定の放置**: 初期設定後のメンテナンスを怠らない
- **単一ツール依存**: 複数のツールの特性を理解し適切に使い分け
- **ドキュメント軽視**: claude.mdの更新を軽視しない
- **セキュリティ軽視**: Secrets管理やアクセス権限を適切に設定

## 🆘 サポートとコミュニティ

### 公式ドキュメント
- **Claude Code**: https://docs.anthropic.com/claude-code
- **GitHub Actions**: https://docs.github.com/actions
- **SuperClaude**: (フレームワークドキュメント)

### トラブルシューティング
```bash
# 設定検証
./scripts/validate-setup.sh

# 詳細ログ確認
gh run list --workflow=ci-basic.yml
gh api repos/:owner/:repo/actions/runs/:run-id/logs

# 設定リセット
./scripts/setup-integration.sh
# 選択: 6 (cleanup) → 再セットアップ
```

---

## 🎉 まとめ

この統合開発環境により：

1. **開発効率の大幅向上** - AI支援による作業の高速化
2. **コード品質の継続的向上** - 自動化された品質保証
3. **学習の促進** - 開発過程での知識蓄積
4. **チーム全体のレベルアップ** - ベストプラクティスの共有

適切に活用することで、従来の開発フローを大きく改善できます。

**Happy Coding with AI-Enhanced Development Environment!** 🚀✨