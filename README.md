# AI Overview LP Theme

AI検索対策プラグインのランディングページ用WordPressテーマです。Adobe Spectrumデザインシステムに基づいたモダンで洗練されたデザインを提供します。

## 概要

Google検索にAI Overview（AIサマリ）が導入された新時代に対応したLP構築用WordPressテーマです。SEOからAIO（AI Overview Optimization）への移行を訴求するプロフェッショナルなランディングページを提供します。

## 技術スタック

- **言語**: PHP, HTML5, CSS3, JavaScript
- **フレームワーク**: WordPress
- **デザインシステム**: Adobe Spectrum
- **ライブラリ**: jQuery

## 特徴

- **Adobe Spectrumデザインシステム**に基づいたUI
- **レスポンシブデザイン**対応（モバイルファースト）
- **カスタム投稿タイプ「コラム」**付属
- **SEO最適化**済み
- **アクセシビリティ**対応
- **モダンなJavaScript機能**（スムーススクロール、アニメーション等）
- **FAQ アコーディオン**機能
- **ソーシャルシェア**機能
- **プログレスバー**（記事読み進み表示）

## セットアップ

### 前提条件
- WordPress 5.0以上
- PHP 7.4以上

### インストール

1. このテーマフォルダを`wp-content/themes/`にアップロード
2. WordPress管理画面の「外観」→「テーマ」で「AI Overview LP Theme」を有効化
3. 必要に応じて「外観」→「カスタマイズ」でCTAボタンの設定を行う

### 開発環境セットアップ
```bash
# リポジトリのクローン
git clone https://github.com/ryojiwata0103/ai-overview-wp-theme.git

# WordPressのthemesディレクトリに配置
cp -r ai-overview-wp-theme /path/to/wordpress/wp-content/themes/
```

## テンプレート構成

### メインテンプレート
- `front-page.php` - フロントページ（LPのメインページ）
- `archive-column.php` - コラム一覧ページ
- `single-column.php` - コラム詳細ページ
- `index.php` - 基本テンプレート

### テーマファイル
- `style.css` - メインスタイルシート
- `functions.php` - テーマ機能定義
- `header.php` - ヘッダーテンプレート
- `footer.php` - フッターテンプレート

### アセット
- `assets/css/custom.css` - カスタムスタイル
- `assets/js/main.js` - メインJavaScript
- `assets/js/smooth-scroll.js` - スムーススクロール機能

## カスタマイズ

### CTAボタンの設定
WordPress管理画面の「外観」→「カスタマイズ」→「CTAボタン設定」で以下を設定できます：
- CTAボタンのテキスト
- CTAボタンのリンク先URL

### メニューの設定
「外観」→「メニュー」で以下のメニューを設定できます：
- Primary Menu（ヘッダーメニュー）
- Footer Menu（フッターメニュー）

### ウィジェットエリア
以下のウィジェットエリアが利用可能です：
- サイドバー
- フッター1
- フッター2
- フッター3

## コラム機能

### カスタム投稿タイプ「コラム」
- 通常の投稿とは別に「コラム」投稿タイプが利用可能
- カテゴリー分類対応
- アーカイブページとシングルページ専用テンプレート

### URL構造
- コラム一覧：`/column/`
- コラム詳細：`/column/post-name/`
- カテゴリー別：`/column-category/category-name/`

## LP構成（10セクション）

1. **ファーストビュー** - キャッチコピーとCTA
2. **問題提起** - 従来SEOの限界
3. **解決策** - プラグインの3つの機能
4. **ベネフィット** - 導入メリット3点
5. **導入フロー** - 3ステップの簡単さ
6. **デモ誘導** - 無料体験への導線
7. **ユーザーの声** - 導入事例2件
8. **FAQ** - よくある質問4項目
9. **今後の展望** - 信頼性強化
10. **クロージング** - 最終行動喚起

## ブラウザサポート

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## 開発ガイドライン

### コーディング規約
- WordPress標準規約に準拠
- Adobe Spectrumデザイン原則の遵守
- レスポンシブデザイン必須
- アクセシビリティ対応

### Git運用
- ブランチ命名：`feature/機能名`、`fix/修正内容`
- コミットメッセージ：日本語可
- PRテンプレート使用必須

## Claude Code連携

このテンプレートにはClaude Code GitHub Actionが設定済みです。

### 使用方法
1. リポジトリ設定でシークレット`CLAUDE_CODE_OAUTH_TOKEN`を設定
2. IssueやPRで`@claude`とメンションしてClaude Codeを呼び出し

## ライセンス

GPL v2 or later

## サポート

このテーマは教育・学習目的で作成されています。商用利用の際は適切なライセンスとサポートを確認してください。