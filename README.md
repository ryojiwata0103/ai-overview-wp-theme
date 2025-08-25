# AI Overview LP Theme

AI検索対策プラグインのランディングページ用WordPressテーマです。Adobe Spectrumデザインシステムに基づいたモダンで洗練されたデザインを提供します。

## 特徴

- **Adobe Spectrumデザインシステム**に基づいたUI
- **レスポンシブデザイン**対応
- **カスタム投稿タイプ「コラム」**付属
- **SEO最適化**済み
- **アクセシビリティ**対応
- **モダンなJavaScript機能**（スムーススクロール、アニメーション等）

## インストール方法

1. このテーマフォルダを`wp-content/themes/`にアップロード
2. WordPress管理画面の「外観」→「テーマ」で「AI Overview LP Theme」を有効化
3. 必要に応じて「外観」→「カスタマイズ」でCTAボタンの設定を行う

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

## 必要な設定

### パーマリンク設定
WordPress管理画面の「設定」→「パーマリンク設定」で「投稿名」または「カスタム構造」を選択してください。

### 推奨プラグイン
- Yoast SEO（SEO最適化）
- Contact Form 7（お問い合わせフォーム）
- W3 Total Cache（パフォーマンス最適化）

## カスタマイズガイド

### カラーパレットの変更
`style.css`の`:root`セクションでCSS変数を変更することで、サイト全体のカラーパレットをカスタマイズできます。

### セクションの追加・削除
`front-page.php`を編集することで、LPのセクションを自由に追加・削除・並び替えできます。

### フォントの変更
CSS変数`--font-family-base`と`--font-family-heading`を変更することで、サイト全体のフォントを変更できます。

## ブラウザサポート

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## ライセンス

GPL v2 or later

## サポート

このテーマは教育・学習目的で作成されています。商用利用の際は適切なライセンスとサポートを確認してください。