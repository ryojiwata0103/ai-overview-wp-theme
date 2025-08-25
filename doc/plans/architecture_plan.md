# AI Overview LP Theme - アーキテクチャ設計書

## プロジェクト概要

**目的**: AI検索対策プラグイン訴求用ランディングページテーマ  
**対象**: SEO→AIO移行を検討する企業・個人ブロガー  
**戦略**: 危機感→解決策→安心感の3段階構成

## 技術アーキテクチャ

### デザインシステム
```
Adobe Spectrum Design System
├── カラーパレット
│   ├── Primary: Blue 600 (#0073FF)
│   ├── Secondary: Blue 700 (#0062E1)
│   ├── Gray Scale: 50-900
│   └── Accent: Green 500, Red 600
├── タイポグラフィ
│   ├── フォント: San Francisco Pro Display
│   ├── スケール: 14px-56px
│   └── ライン高: 1.2-1.8
└── スペーシング
    ├── 基本単位: 4px, 8px, 16px, 24px
    ├── セクション: 64px, 96px
    └── コンポーネント: 32px, 48px
```

### WordPress構造
```
Theme Architecture
├── Core Templates
│   ├── front-page.php (LP メイン)
│   ├── archive-column.php (コラム一覧)
│   ├── single-column.php (コラム詳細)
│   └── index.php (フォールバック)
├── Template Parts
│   ├── header.php (ナビゲーション)
│   └── footer.php (フッター・ウィジェット)
├── Functions
│   ├── Custom Post Type: column
│   ├── Custom Taxonomy: column_category
│   ├── Widget Areas: 4箇所
│   └── Customizer: CTA設定
└── Assets
    ├── CSS: style.css + custom.css
    └── JS: main.js + smooth-scroll.js
```

## コンポーネント設計

### レイアウトコンポーネント
```
Container System
├── .container (max-width: 1200px)
├── .container-narrow (max-width: 960px)
└── Grid System
    ├── .grid-2 (auto-fit, minmax(300px, 1fr))
    └── .grid-3 (auto-fit, minmax(250px, 1fr))
```

### UIコンポーネント
```
Component Library
├── Buttons
│   ├── .btn-primary (Blue gradient)
│   ├── .btn-secondary (Outline)
│   └── .btn-large (18px font)
├── Cards
│   ├── .card (基本カード)
│   ├── .benefit-card (メリット表示)
│   └── .testimonial-card (口コミ)
├── Interactive
│   ├── FAQ Accordion
│   ├── Progress Bar
│   └── Back to Top
└── Form Elements
    ├── Error States
    └── Validation
```

## 機能仕様

### LP機能マップ
```
Landing Page Features
├── コンバージョン最適化
│   ├── 複数CTA配置 (5箇所)
│   ├── 危機感→解決策フロー
│   └── 段階的信頼構築
├── ユーザビリティ
│   ├── スムーススクロール
│   ├── レスポンシブナビ
│   └── 読み進み可視化
└── エンゲージメント
    ├── インタラクティブFAQ
    ├── アニメーション効果
    └── ソーシャルシェア
```

### コラム機能
```
Column System
├── 投稿管理
│   ├── Custom Post Type: column
│   ├── Category: column_category
│   └── SEO最適化
├── 表示機能
│   ├── アーカイブ（カテゴリーフィルター）
│   ├── シングル（関連記事表示）
│   └── ペジネーション
└── UX機能
    ├── 読み進みバー
    ├── シェア機能
    └── ナビゲーション
```

## パフォーマンス設計

### 最適化戦略
```
Performance Strategy
├── CSS最適化
│   ├── CSS変数による統一管理
│   ├── モバイルファースト
│   └── 効率的なセレクター
├── JavaScript
│   ├── jQuery依存（WordPress標準）
│   ├── イベント委譲
│   └── Intersection Observer
└── 画像戦略
    ├── SVGアイコン活用
    ├── WebP対応予定
    └── Lazy Loading実装済み
```

### 読み込み最適化
- CSS: 2ファイル（style.css + custom.css）
- JS: 2ファイル（main.js + smooth-scroll.js）
- フォント: システムフォント優先
- アイコン: インラインSVG

## セキュリティ設計

### WordPress標準対応
```
Security Measures
├── データサニタイゼーション
│   ├── esc_html() - テキスト出力
│   ├── esc_url() - URL出力
│   └── sanitize_text_field() - 入力値
├── XSS対策
│   ├── wp_head() / wp_footer()
│   ├── 適切なエスケープ
│   └── nonce検証準備
└── CSRF対策
    ├── WordPress標準関数使用
    └── カスタマイザー保護
```

## 拡張計画

### フェーズ1（現在完了）
- ✅ 基本テーマ構造
- ✅ Adobe Spectrumデザイン
- ✅ LP完全実装
- ✅ コラム機能

### フェーズ2（将来拡張）
```
Phase 2 Roadmap
├── 機能拡張
│   ├── Contact Form 7統合
│   ├── A/Bテスト機能
│   └── アナリティクス統合
├── パフォーマンス
│   ├── 画像最適化
│   ├── キャッシュ戦略
│   └── CDN統合
└── SEO強化
    ├── 構造化データ
    ├── OGP最適化
    └── サイトマップ自動生成
```

## 技術的債務

### 現在の制約
- MySQL依存（WordPress動的機能）
- jQuery依存（WordPress標準）
- PHP 7.4以上必須

### 改善計画
- モダンJavaScript移行検討
- WebP画像対応
- パフォーマンス計測設定