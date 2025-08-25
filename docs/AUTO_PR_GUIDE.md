# 🤖 Claude Code 自動PR作成ガイド

Claude Codeによる開発完了時に自動でプルリクエストを作成する機能の完全ガイドです。

## 🎯 概要

Claude Codeの実装作業が完了すると、自動的に以下が実行されます：
1. **新しいブランチ作成** - タイムスタンプ付きの一意なブランチ
2. **変更のコミット** - 適切なコミットメッセージでの保存
3. **プルリクエスト作成** - 詳細な説明付きのPR
4. **CI/CDトリガー** - 品質チェックの自動実行

## 🚀 利用方法

### 方法1: 自動PR専用コマンド
```bash
# Issueやコメントで以下を使用
@claude-dev この機能を実装してください
@claude --auto-pr ユーザー認証機能を追加
@claude --create-pr バグを修正してください
```

### 方法2: 既存Claudeの拡張フラグ
```bash
# 通常の@claudeに自動PR作成フラグを追加
@claude --auto-pr この実装をお願いします
@claude 新機能を実装 --create-pr
```

### 方法3: Issue Template利用
1. **新しいIssue作成** → **🤖 Claude Code Development Request** テンプレート選択
2. **要件記入** → 実装内容・優先度・範囲を入力
3. **自動PR作成を有効化**
4. **Issue内で** `@claude-dev` **メンション**

## 📋 実装パターン別セットアップ

### パターンA: 新規専用ワークフロー（推奨）

```bash
# claude-auto-pr.yml が作成済み
# 以下のコマンドで即座に利用開始
@claude-dev 新しい機能を実装してください
```

**特徴:**
- 既存のclaude.ymlに影響なし
- 専用の自動PR作成フロー
- より安定した動作

### パターンB: 既存ワークフロー拡張

```bash
# claude.yml を claude-enhanced.yml.template で置き換え
mv .github/workflows/claude-enhanced.yml.template .github/workflows/claude.yml

# フラグ付きコマンドで利用
@claude --auto-pr 実装をお願いします
```

**特徴:**
- 既存機能を維持しつつ拡張
- フラグによる選択的利用
- 段階的移行が可能

## 🔧 カスタマイズ設定

### ブランチ命名規則
```yaml
# デフォルト: claude-auto-dev-{issue-number}-{timestamp}
BRANCH_NAME="claude-auto-dev-${ISSUE_NUMBER}-${TIMESTAMP}"

# カスタマイズ例
BRANCH_NAME="feat/claude-${ISSUE_NUMBER}-$(date +%m%d)"
BRANCH_NAME="auto-impl-${ISSUE_NUMBER}"
```

### PRテンプレート
```yaml
# 自動生成されるPRの内容をカスタマイズ
PR_TITLE="feat: ${ISSUE_TITLE}"  # デフォルト

# カスタマイズ例
PR_TITLE="🤖 Auto: ${ISSUE_TITLE}"
PR_TITLE="[Claude] ${ISSUE_TITLE}"
```

### 許可するツール制限
```yaml
# Claude Codeが使用できるコマンドを制限
allowed_tools: |
  Bash(git add -A)
  Bash(git commit -m *)
  Bash(git push *)
  Bash(pnpm install)
  Bash(pnpm run build)
  Bash(pnpm run test)
  Bash(pnpm run lint)
  # セキュリティ上、削除系コマンドは除外
```

## 📊 実行フロー詳細

```mermaid
graph TD
    A[Issue/コメントで@claude-dev] --> B{自動PRフラグ?}
    B -->|Yes| C[Claude Code実行]
    B -->|No| D[通常のClaude実行]
    
    C --> E[コード実装・変更]
    E --> F[変更をgit commit]
    F --> G[新ブランチ作成]
    G --> H[ブランチをpush]
    H --> I[PR自動作成]
    
    I --> J[CI/CDパイプライン実行]
    I --> K[元Issueにコメント投稿]
    
    J --> L[品質チェック完了]
    K --> M[レビュー・承認・マージ]
```

## ✅ 自動PR作成時のチェック項目

### 自動実行される検証
- [x] **変更検出** - 実際にコードが変更されているか
- [x] **重複PR防止** - 同じIssueに対する既存PRの確認
- [x] **ブランチ一意性** - タイムスタンプによる衝突回避
- [x] **コミット品質** - 意味のあるコミットメッセージ
- [x] **CI/CDトリガー** - 品質チェックの自動実行

### 手動確認が必要な項目
- [ ] **実装内容の正確性** - 要求仕様との一致
- [ ] **テストカバレッジ** - 新機能に対する適切なテスト
- [ ] **ドキュメント更新** - claude.md等の更新確認
- [ ] **セキュリティ検証** - 脆弱性の有無
- [ ] **パフォーマンス影響** - 性能劣化の有無

## 🚨 トラブルシューティング

### よくある問題と解決策

#### 1. PRが作成されない
```bash
# 原因チェック
gh run list --workflow=claude-auto-pr.yml
gh run view <run-id> --log

# 一般的な原因
- GitHub Tokenの権限不足
- 変更が検出されない
- 既存PRの重複
```

**解決方法:**
```bash
# 権限確認
gh auth status
# Settings > Actions > General > Workflow permissions で Write権限を確認

# 手動PR作成テスト
gh pr create --title "Test" --body "Test PR"
```

#### 2. Claude Codeが変更をコミットしない
```yaml
# claude.yml の custom_instructions を強化
custom_instructions: |
  実装完了時は必ず以下を実行：
  1. git add -A
  2. git commit -m "具体的なコミットメッセージ"
  3. 変更完了を明記
```

#### 3. CI/CDが失敗する
```bash
# PRのCI/CD状況確認
gh pr checks <pr-number>

# 一般的な解決策
- TypeScript型エラーの修正
- テスト追加・修正
- ESLint/Prettier問題の解消
```

### デバッグ手順
```bash
# 1. ワークフロー実行状況確認
gh run list --workflow=claude-auto-pr.yml --limit=5

# 2. 特定実行の詳細ログ確認
gh run view <run-id> --log

# 3. PRステータス確認
gh pr list --author="github-actions[bot]"

# 4. ブランチ確認
git branch -r | grep "claude-auto"
```

## 📈 効果測定指標

### 開発効率指標
- **実装→PR時間**: Issue作成からPR完成までの時間
- **レビュー時間**: PR作成からマージまでの時間
- **自動化率**: 手動作業 vs 自動化作業の比率

### 品質指標
- **CI/CD成功率**: 自動作成PRのパイプライン通過率
- **レビューサイクル**: レビュー指摘事項の平均数
- **バグ率**: 自動実装機能でのバグ発見率

### 利用状況追跡
```bash
# 月次自動PR作成数
gh pr list --author="github-actions[bot]" --label="auto-generated" --search="created:>2025-01-01"

# 自動PR成功率
gh pr list --author="github-actions[bot]" --state=merged --search="created:>2025-01-01"
```

## 🎯 ベストプラクティス

### DO ✅
- **明確な要求仕様** - Issueに詳細で具体的な実装要件を記載
- **適切なスコープ** - 1つのPRにつき1つの機能・修正に限定
- **テスト重視** - 実装指示にテストケースの作成を明記
- **レビューの徹底** - 自動作成でも人間のレビューを必須
- **ドキュメント更新** - claude.md等の保守ドキュメント更新

### DON'T ❌
- **複雑すぎる要求** - 複数機能を同時に依頼しない
- **セキュリティ軽視** - 権限や認証に関わる実装は慎重に
- **テスト省略** - テストなしでのマージは避ける
- **盲目的信頼** - 自動実装でも必ずコードレビューを実行
- **設定放置** - 定期的な設定見直しとメンテナンス

## 🔐 セキュリティ考慮事項

### 必要な権限管理
```yaml
# 最小権限の原則
permissions:
  contents: write      # ブランチ作成・プッシュ用
  pull-requests: write # PR作成用
  issues: write        # Issue更新用
  # admin権限は不要
```

### Secrets管理
```bash
# 必要なSecrets
CLAUDE_CODE_OAUTH_TOKEN  # Claude Code用（必須）
GITHUB_TOKEN            # GitHub API用（自動設定）

# 設定確認
gh secret list
```

### セキュリティチェックポイント
- [ ] 自動実装でのシークレット情報漏洩防止
- [ ] 危険なコマンド実行の制限
- [ ] PR作成権限の適切な設定
- [ ] 外部リポジトリへの意図しないプッシュ防止

## 💡 高度な活用例

### 複数環境での自動デプロイ連携
```yaml
# PR作成 → ステージング自動デプロイ
- name: Auto-deploy to staging
  if: contains(github.head_ref, 'claude-auto-dev')
  run: |
    echo "Deploying to staging environment"
    # デプロイコマンド
```

### Slack通知との連携
```yaml
# PR作成時にSlack通知
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: success
    text: "🤖 Claude Codeが新しいPRを作成しました: ${{ steps.create_pr.outputs.pr_url }}"
```

### 自動レビュアー割当
```yaml
# PR作成時に自動でレビュアーを割当
- name: Assign reviewers
  run: |
    gh pr edit ${{ steps.create_pr.outputs.pr_number }} --add-reviewer="@team/reviewers"
```

---

## 🎉 まとめ

Claude Code自動PR作成機能により：

1. **開発スピード向上** - Issue → 実装 → PR → デプロイの自動化
2. **品質保証** - 自動CI/CD + 人間レビューの組み合わせ
3. **一貫性確保** - 標準化されたブランチ・PR・コミット形式
4. **追跡可能性** - 完全な開発履歴とドキュメント化

適切な設定とベストプラクティスの遵守により、開発効率を大幅に向上させることができます。

**Happy Automated Development with Claude Code!** 🚀✨