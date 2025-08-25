# プロジェクト開発ガイド - Claude Code

## プロジェクト概要
<!-- プロジェクトの概要・目的を記載 -->

## 技術スタック

### フロントエンド
- **フレームワーク**: [例: React, Vue, Next.js]
- **言語**: TypeScript
- **スタイリング**: [例: CSS Modules, Tailwind CSS, styled-components]
- **状態管理**: [例: Redux, Zustand, Context API]

### バックエンド
- **フレームワーク**: [例: Express, Hono, NestJS, FastAPI]
- **データベース**: [例: PostgreSQL, MongoDB, SQLite]
- **ORM/ODM**: [例: Prisma, TypeORM, Mongoose]

### インフラ・デプロイ
- **デプロイ先**: [例: Vercel, Netlify, AWS, Railway]
- **CI/CD**: GitHub Actions（設定済み）
- **コンテナ**: [例: Docker, Docker Compose]

### 開発ツール
- **パッケージマネージャー**: pnpm（推奨）
- **リンター**: ESLint（設定済み）
- **フォーマッター**: Prettier（設定済み）
- **テスト**: [例: Jest, Vitest, Playwright]

## プロジェクト構造
```
プロジェクト名/
├── src/                     # ソースコード
│   ├── components/          # コンポーネント
│   ├── pages/              # ページ
│   ├── utils/              # ユーティリティ
│   └── types/              # 型定義
├── public/                 # 静的ファイル
├── docs/                   # ドキュメント
├── .github/                # GitHub設定
│   ├── workflows/          # GitHub Actions
│   └── PULL_REQUEST_TEMPLATE.md
├── claude.md              # 本ファイル（開発履歴管理）
├── package.json
├── tsconfig.json
└── README.md
```

## セットアップ手順

### 初期設定
```bash
# 依存関係のインストール
pnpm install

# 環境変数の設定
cp .env.example .env
# .env ファイルを編集して必要な値を設定

# 開発サーバー起動
pnpm dev
```

### Claude Code連携設定
1. **GitHubシークレット設定**
   - Settings → Secrets → `CLAUDE_CODE_OAUTH_TOKEN` を追加
2. **Claude Code呼び出し**
   - Issue・PRで `@claude` とメンション
   - GitHub Actions経由で自動実行

## 開発ワークフロー

### ブランチ戦略
- `main` - 本番ブランチ
- `feature/機能名` - 機能開発ブランチ
- `fix/修正内容` - バグ修正ブランチ

### コミット規約
```
feat: 新機能追加
fix: バグ修正
docs: ドキュメント更新
style: コードスタイル変更
refactor: リファクタリング
test: テスト追加・修正
chore: その他の変更
```

### PR作成時のチェックリスト
- [ ] 機能は正常に動作するか
- [ ] テストは通るか
- [ ] リント・フォーマットは適用されているか
- [ ] Context7でベストプラクティスを確認したか
- [ ] ドキュメント更新が必要な場合は更新したか

## 開発履歴

### [日付] 初期セットアップ
- プロジェクト作成
- 基本的な開発環境構築
- Claude Code GitHub Action設定

<!-- 以下に開発履歴を追記していく -->

### [YYYY-MM-DD] 機能名・修正内容
- 実装内容の概要
- 使用した技術・ライブラリ
- 発生した問題と解決方法
- Claude Codeとの連携内容

**技術的詳細**:
```
具体的なコード変更やアーキテクチャの説明
```

**学習・発見事項**:
- 新しく学んだこと
- 効率的だった実装パターン
- 避けるべき実装方法

---

### [YYYY-MM-DD] 例: ユーザー認証機能実装
- Next.js App RouterとNextAuth.jsを使用
- Google OAuth2認証を実装
- セッション管理とミドルウェア設定

**技術的詳細**:
```typescript
// middleware.ts でルート保護を実装
export { default } from "next-auth/middleware"
export const config = { matcher: ["/dashboard/:path*"] }
```

**学習・発見事項**:
- App Routerでのセッション管理は `auth()` 関数が便利
- Claude Codeが最新のNextAuth.js v5パターンを提案してくれた
- Context7でNext.js 14の最新ベストプラクティスを確認

---

## トラブルシューティング

### よくある問題

#### 問題: [具体的な問題]
**症状**: 
**原因**: 
**解決方法**: 
```bash
# 解決コマンド例
```

## パフォーマンス最適化

### 実施済み最適化
- [ ] バンドルサイズ最適化
- [ ] 画像最適化
- [ ] レイジーローディング
- [ ] キャッシュ戦略

### 測定結果
- **初期読み込み時間**: 
- **Core Web Vitals**: 
- **Lighthouse スコア**: 

## デプロイメント

### デプロイ手順
```bash
# ビルド
pnpm build

# デプロイ（例：Vercel）
vercel --prod
```

### 環境変数設定
- `NODE_ENV`: production
- `DATABASE_URL`: [本番DB接続文字列]
- `NEXTAUTH_SECRET`: [JWT署名用シークレット]
- その他プロジェクト固有の環境変数

## セキュリティ対策

### 実装済み対策
- [ ] 環境変数による機密情報管理
- [ ] CORS設定
- [ ] CSP (Content Security Policy)
- [ ] 入力値検証・サニタイズ
- [ ] 認証・認可機能

## 今後の計画

### 短期計画（1-2週間）
- [ ] 
- [ ] 
- [ ] 

### 中期計画（1-3ヶ月）
- [ ] 
- [ ] 
- [ ] 

### 長期計画（3ヶ月以上）
- [ ] 
- [ ] 
- [ ] 

## 参考資料

### ドキュメント
- [プロジェクト関連のドキュメントリンク]
- [使用ライブラリの公式ドキュメント]

### 学習リソース
- [有用な記事・チュートリアル]
- [参考にしたサンプルプロジェクト]

---

> 📄 **最終更新**: [YYYY-MM-DD]  
> 🤖 **Claude Code連携**: 有効  
> 📋 **管理方式**: 開発履歴追跡型