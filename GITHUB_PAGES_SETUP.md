# GitHub Pages セットアップガイド

このWordPressテーマを GitHub Pages で静的サイトとして公開するためのセットアップ手順です。

## 🚀 セットアップ手順

### 1. リポジトリ設定

1. **GitHub リポジトリの Settings に移動**
2. **Pages セクションに移動**
3. **Source を "GitHub Actions" に設定**

### 2. GitHub Actions ワークフローの確認

`.github/workflows/deploy-pages.yml` ファイルが自動的に作成されており、以下の機能を提供します：

- `main` ブランチへの push 時に自動デプロイ
- Pull Request でのプレビュー
- 手動でのデプロイ実行

### 3. 静的ファイル構成

以下の静的HTMLファイルが作成されています：

```
├── index.html          # メインランディングページ
├── columns.html        # コラム一覧ページ  
├── column-sample.html  # サンプルコラム記事
├── style.css          # メインスタイルシート
├── assets/
│   ├── css/
│   │   └── custom.css # カスタムスタイル
│   └── js/
│       ├── main.js    # メインJavaScript
│       └── smooth-scroll.js # スムーススクロール
```

## 📝 WordPressテーマからの変更点

### 変換された機能

✅ **完全対応**
- ランディングページのデザインとレイアウト
- レスポンシブデザイン
- Adobe Spectrumデザインシステム
- スムーススクロールとナビゲーション
- FAQ アコーディオン機能

✅ **静的化対応**
- メニューナビゲーション（静的リンクに変更）
- フッター情報
- コラムページ構造
- ソーシャルシェアボタン

### 動的機能の制限

⚠️ **注意：以下の機能は静的サイトでは動作しません**
- WordPress管理画面での設定変更
- CTAボタンURL/テキストのカスタマイザー設定
- 動的なコンテンツ生成
- データベース連携機能
- コンタクトフォーム
- 実際のブログ機能

## 🎨 カスタマイズ方法

### CTAボタンの変更
`index.html` の以下の部分を編集：
```html
<a href="#demo" class="btn btn-primary btn-large">
    今すぐチェックしてみる
</a>
```

### コンテンツの更新
- `index.html`: メインランディングページ
- `columns.html`: コラム一覧ページ
- `column-sample.html`: サンプル記事ページ

### スタイルの変更
- `style.css`: メインスタイルシート
- `assets/css/custom.css`: カスタムスタイル

## 🌐 公開URL

デプロイ後、サイトは以下のURLでアクセス可能です：
```
https://{username}.github.io/{repository-name}/
```

## 🔧 トラブルシューティング

### デプロイが失敗する場合

1. **Permissions の確認**
   - Settings > Actions > General > Workflow permissions
   - "Read and write permissions" を選択

2. **Pages 設定の確認**  
   - Settings > Pages > Source が "GitHub Actions" になっているか確認

3. **ワークフローログの確認**
   - Actions タブでエラーログを確認

### ファイルが見つからない場合

静的サイトではパスの大文字小文字が重要です：
- `index.html` (ファイル名は小文字)
- リンクパスも正確に記述する

## 📞 サポート

問題が発生した場合は、以下を確認してください：
1. ブラウザの開発者ツールでエラーログを確認
2. GitHub Actions のログを確認  
3. ファイルパスとリンクが正しいか確認

---

**注意**: このセットアップにより、WordPressテーマの見た目と基本機能を GitHub Pages で再現できますが、WordPressの動的機能（管理画面、データベース、プラグイン機能など）は使用できません。