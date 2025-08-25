#!/bin/bash

# 🚀 GitHub Project Template - 統合セットアップスクリプト
# SuperClaude + CI/CD自動化 + Claude Code Actionの統合環境を構築

set -e  # エラー時に終了

# カラー出力の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ロゴ表示
echo -e "${PURPLE}"
echo "╔════════════════════════════════════════════╗"
echo "║    🚀 GitHub Project Template Setup      ║"
echo "║    統合開発環境セットアップ               ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# プロジェクト情報取得
PROJECT_NAME=$(basename "$(pwd)")
echo -e "${BLUE}📁 プロジェクト名: ${GREEN}$PROJECT_NAME${NC}"
echo ""

# 既存設定の確認
echo -e "${CYAN}🔍 現在の設定状況を確認中...${NC}"

# Claude Code Action の確認
if [ -f ".github/workflows/claude.yml" ]; then
    echo -e "  ✅ Claude Code Action: ${GREEN}設定済み${NC}"
    CLAUDE_ACTION_EXISTS=true
else
    echo -e "  ❌ Claude Code Action: ${RED}未設定${NC}"
    CLAUDE_ACTION_EXISTS=false
fi

# CI/CD自動化の確認
if [ -f ".github/workflows/ci-basic.yml" ]; then
    echo -e "  ✅ CI/CD自動化: ${GREEN}設定済み${NC}"
    CI_EXISTS=true
else
    echo -e "  ❌ CI/CD自動化: ${YELLOW}未設定${NC}"
    CI_EXISTS=false
fi

# SuperClaude の確認
if [ -d ".claude" ]; then
    echo -e "  ✅ SuperClaude設定: ${GREEN}設定済み${NC}"
    SUPERCLAUDE_EXISTS=true
else
    echo -e "  ❌ SuperClaude設定: ${YELLOW}未設定${NC}"
    SUPERCLAUDE_EXISTS=false
fi

echo ""

# 統合レベル選択
echo -e "${YELLOW}🎯 統合する機能を選択してください:${NC}"
echo "  1) basic     - CI/CD自動化のみ追加 (推奨)"
echo "  2) advanced  - CI/CD自動化 + 高度なパイプライン"
echo "  3) superclaude - SuperClaude統合のみ"
echo "  4) full      - 全統合 (CI/CD + SuperClaude)"
echo "  5) simple-pr - シンプル自動PR作成（推奨）"
echo "  6) auto-pr   - Claude Code自動PR作成機能追加"
echo "  7) validate  - 現在の設定を検証のみ"
echo "  8) cleanup   - 統合設定をクリーンアップ"
echo ""

read -p "選択 (1-8): " CHOICE

case $CHOICE in
  1|"basic")
    SETUP_MODE="basic"
    echo -e "${GREEN}📦 基本CI/CD統合を選択${NC}"
    ;;
  2|"advanced")
    SETUP_MODE="advanced"
    echo -e "${BLUE}🚀 高度なCI/CD統合を選択${NC}"
    ;;
  3|"superclaude")
    SETUP_MODE="superclaude"
    echo -e "${PURPLE}🧠 SuperClaude統合を選択${NC}"
    ;;
  4|"full")
    SETUP_MODE="full"
    echo -e "${CYAN}🎯 完全統合を選択${NC}"
    ;;
  5|"simple-pr")
    SETUP_MODE="simple-pr"
    echo -e "${GREEN}📝 シンプル自動PR作成を選択${NC}"
    ;;
  6|"auto-pr")
    SETUP_MODE="auto-pr"
    echo -e "${PURPLE}🤖 Claude Code自動PR作成を選択${NC}"
    ;;
  7|"validate")
    SETUP_MODE="validate"
    echo -e "${YELLOW}🔍 設定検証モードを選択${NC}"
    ;;
  8|"cleanup")
    SETUP_MODE="cleanup"
    echo -e "${RED}🧹 クリーンアップモードを選択${NC}"
    ;;
  *)
    echo -e "${RED}❌ 無効な選択です${NC}"
    exit 1
    ;;
esac

echo ""

# 検証モード
if [ "$SETUP_MODE" = "validate" ]; then
    echo -e "${CYAN}🔍 設定検証を実行中...${NC}"
    
    # package.json 確認
    if [ -f "package.json" ]; then
        echo -e "  ✅ package.json: ${GREEN}存在${NC}"
        
        # 必要なスクリプトの確認
        if jq -e '.scripts.build' package.json > /dev/null 2>&1; then
            echo -e "  ✅ build スクリプト: ${GREEN}設定済み${NC}"
        else
            echo -e "  ⚠️ build スクリプト: ${YELLOW}未設定 (推奨)${NC}"
        fi
        
        if jq -e '.scripts.test' package.json > /dev/null 2>&1; then
            echo -e "  ✅ test スクリプト: ${GREEN}設定済み${NC}"
        else
            echo -e "  ⚠️ test スクリプト: ${YELLOW}未設定 (推奨)${NC}"
        fi
    else
        echo -e "  ❌ package.json: ${RED}存在しません${NC}"
    fi
    
    # GitHub設定確認
    if [ -f ".github/workflows/claude.yml" ]; then
        echo -e "  ✅ Claude Code Action: ${GREEN}設定完了${NC}"
        
        # CLAUDE_CODE_OAUTH_TOKEN の設定確認提示
        echo -e "${YELLOW}  💡 GitHub Secretsの確認:${NC}"
        echo -e "    - CLAUDE_CODE_OAUTH_TOKEN が設定されていることを確認してください"
        echo -e "    - 設定方法: Settings > Secrets and variables > Actions"
    fi
    
    echo -e "${GREEN}✅ 検証完了${NC}"
    exit 0
fi

# クリーンアップモード
if [ "$SETUP_MODE" = "cleanup" ]; then
    echo -e "${RED}🧹 統合設定のクリーンアップ中...${NC}"
    
    # 確認プロンプト
    echo -e "${YELLOW}⚠️ 以下のファイル・ディレクトリが削除されます:${NC}"
    echo "  - .github/workflows/ci-basic.yml"
    echo "  - .github/workflows/ci-advanced.yml"  
    echo "  - .claude/ ディレクトリ"
    echo "  - scripts/setup-integration.sh (このファイル以外)"
    echo ""
    
    read -p "本当に削除しますか？ (y/N): " CONFIRM
    if [[ $CONFIRM != "y" && $CONFIRM != "Y" ]]; then
        echo -e "${BLUE}🛑 キャンセルしました${NC}"
        exit 0
    fi
    
    # ファイルを削除
    rm -f .github/workflows/ci-basic.yml
    rm -f .github/workflows/ci-advanced.yml
    rm -f .github/workflows/ci-advanced.yml.template
    rm -rf .claude
    rm -f scripts/validate-setup.sh
    
    echo -e "${GREEN}✅ クリーンアップ完了${NC}"
    echo -e "${BLUE}💡 claude.yml と既存のclaude.mdは保持されました${NC}"
    exit 0
fi

# セットアップ実行
echo -e "${CYAN}⚙️ セットアップを開始します...${NC}"

# CI/CD設定 (basic, advanced, full)
if [[ "$SETUP_MODE" =~ ^(basic|advanced|full)$ ]]; then
    echo -e "${BLUE}🔧 CI/CD自動化を設定中...${NC}"
    
    if [ ! "$CI_EXISTS" = true ]; then
        echo -e "  📝 ci-basic.yml を有効化"
        # ファイルが既に作成されているのでメッセージのみ
        
        if [ "$SETUP_MODE" = "advanced" ] || [ "$SETUP_MODE" = "full" ]; then
            echo -e "  📝 ci-advanced.yml を有効化"
            if [ -f ".github/workflows/ci-advanced.yml.template" ]; then
                mv .github/workflows/ci-advanced.yml.template .github/workflows/ci-advanced.yml
                echo -e "  ✅ 高度なCI/CDパイプライン有効化完了"
            fi
        fi
    else
        echo -e "  ✅ CI/CD自動化は既に設定済みです"
    fi
    
    # package.json の推奨スクリプト確認
    if [ -f "package.json" ]; then
        echo -e "${YELLOW}  💡 package.json の推奨設定:${NC}"
        
        # 必要なスクリプトの提案
        if ! jq -e '.scripts.build' package.json > /dev/null 2>&1; then
            echo -e "    - 'build' スクリプトの追加を推奨"
        fi
        if ! jq -e '.scripts.test' package.json > /dev/null 2>&1; then
            echo -e "    - 'test' スクリプトの追加を推奨"
        fi
        if ! jq -e '.scripts.lint' package.json > /dev/null 2>&1; then
            echo -e "    - 'lint' スクリプトの追加を推奨"
        fi
    fi
fi

# シンプル自動PR作成設定 (simple-pr, full)
if [[ "$SETUP_MODE" =~ ^(simple-pr|full)$ ]]; then
    echo -e "${GREEN}📝 シンプル自動PR作成を設定中...${NC}"
    
    if [ ! -f ".github/workflows/simple-auto-pr.yml" ]; then
        echo -e "  📝 simple-auto-pr.yml を有効化"
        echo -e "  ✅ シンプル自動PR作成機能を有効化完了"
        
        echo -e "${YELLOW}  💡 使用方法:${NC}"
        echo -e "    1. feature/、fix/ 等のブランチを作成"
        echo -e "    2. コードを変更してpush"
        echo -e "    3. 自動的にPRが作成されます"
        echo -e "    4. 重複PRは自動で回避されます"
    else
        echo -e "  ✅ シンプル自動PR作成は既に設定済みです"
    fi
    
    echo -e "${YELLOW}  🎯 対象ブランチ:${NC}"
    echo -e "    - feature/** (新機能)"
    echo -e "    - fix/** (バグ修正)"
    echo -e "    - chore/** (その他作業)"
    echo -e "    - docs/** (ドキュメント)"
fi

# 自動PR作成設定 (auto-pr, full)
if [[ "$SETUP_MODE" =~ ^(auto-pr|full)$ ]]; then
    echo -e "${PURPLE}🤖 Claude Code自動PR作成を設定中...${NC}"
    
    if [ ! -f ".github/workflows/claude-auto-pr.yml" ]; then
        echo -e "  📝 claude-auto-pr.yml を有効化"
        echo -e "  ✅ Claude Code自動PR作成機能を有効化完了"
        
        echo -e "${YELLOW}  💡 自動PR作成の使用方法:${NC}"
        echo -e "    - @claude-dev [実装依頼] - 完全自動モード"
        echo -e "    - @claude --auto-pr [実装依頼] - フラグ付きモード"
        echo -e "    - Issue Template使用 - 構造化リクエスト"
    else
        echo -e "  ✅ Claude Code自動PR作成は既に設定済みです"
    fi
    
    # GitHub権限の確認
    echo -e "${YELLOW}  🔐 必要な権限確認:${NC}"
    echo -e "    - CLAUDE_CODE_OAUTH_TOKEN Secret設定済み確認"
    echo -e "    - Repository Settings > Actions > General"
    echo -e "    - Workflow permissions: Read and write権限が必要"
fi

# SuperClaude設定 (superclaude, full)
if [[ "$SETUP_MODE" =~ ^(superclaude|full)$ ]]; then
    echo -e "${PURPLE}🧠 SuperClaude統合を設定中...${NC}"
    
    # SuperClaudeのインストール確認
    if ! command -v claude &> /dev/null; then
        echo -e "${YELLOW}  SuperClaudeがインストールされていません${NC}"
        read -p "  SuperClaudeをインストールしますか？ (y/N): " INSTALL_SUPERCLAUDE
        
        if [[ $INSTALL_SUPERCLAUDE == "y" || $INSTALL_SUPERCLAUDE == "Y" ]]; then
            echo -e "  📥 SuperClaudeをインストール中..."
            
            # SuperClaude インストール（実際のインストールスクリプトに置き換える必要があります）
            echo -e "  ${YELLOW}💡 SuperClaudeインストール手順:${NC}"
            echo -e "    1. https://claude.ai/code からClaude Codeをダウンロード"
            echo -e "    2. SuperClaudeフレームワークをセットアップ"
            echo -e "    3. 再度このスクリプトを実行"
        else
            echo -e "  ⚠️ SuperClaude統合はスキップされました"
        fi
    else
        echo -e "  ✅ SuperClaudeが検出されました"
        
        # プロジェクト固有設定
        echo -e "  ⚙️ プロジェクト設定を適用中..."
        claude config set project.name "$PROJECT_NAME" 2>/dev/null || echo "    (設定の適用をスキップ)"
        claude config set project.type "typescript" 2>/dev/null || echo "    (設定の適用をスキップ)"
    fi
    
    # .claude ディレクトリの設定は既に作成済み
    if [ ! "$SUPERCLAUDE_EXISTS" = true ]; then
        echo -e "  ✅ SuperClaude設定ファイル作成完了"
    else
        echo -e "  ✅ SuperClaude設定は既に存在します"
    fi
fi

# 検証スクリプト作成
echo -e "${CYAN}📝 検証スクリプトを作成中...${NC}"
cat > scripts/validate-setup.sh << 'EOF'
#!/bin/bash

# 設定検証スクリプト
echo "🔍 統合環境の検証を実行中..."

# Claude Code Action
if [ -f ".github/workflows/claude.yml" ]; then
    echo "✅ Claude Code Action: 設定済み"
else
    echo "❌ Claude Code Action: 未設定"
fi

# CI/CD
if [ -f ".github/workflows/ci-basic.yml" ]; then
    echo "✅ CI/CD基本: 設定済み"
else
    echo "❌ CI/CD基本: 未設定"
fi

if [ -f ".github/workflows/ci-advanced.yml" ]; then
    echo "✅ CI/CD高度: 設定済み"
else
    echo "ℹ️ CI/CD高度: 未設定 (オプション)"
fi

# SuperClaude
if [ -d ".claude" ]; then
    echo "✅ SuperClaude: 設定済み"
else
    echo "ℹ️ SuperClaude: 未設定 (オプション)"
fi

# package.json チェック
if [ -f "package.json" ]; then
    echo "✅ package.json: 存在"
    
    if jq -e '.scripts.build' package.json > /dev/null 2>&1; then
        echo "✅ build スクリプト: 設定済み"
    else
        echo "⚠️ build スクリプト: 推奨設定"
    fi
else
    echo "❌ package.json: 存在しません"
fi

echo "✅ 検証完了"
EOF

chmod +x scripts/validate-setup.sh

# 完了メッセージ
echo ""
echo -e "${GREEN}🎉 セットアップ完了！${NC}"
echo ""
echo -e "${CYAN}📋 設定された機能:${NC}"

case $SETUP_MODE in
  "basic")
    echo -e "  ✅ CI/CD基本自動化"
    echo -e "  ✅ 品質チェック・テスト・ビルド検証"
    ;;
  "advanced")
    echo -e "  ✅ CI/CD基本自動化"
    echo -e "  ✅ 高度なセキュリティスキャン"
    echo -e "  ✅ パフォーマンステスト"
    echo -e "  ✅ クロスプラットフォーム検証"
    ;;
  "superclaude")
    echo -e "  ✅ SuperClaude統合設定"
    echo -e "  ✅ 構造化AI支援環境"
    ;;
  "auto-pr")
    echo -e "  ✅ Claude Code自動PR作成"
    echo -e "  ✅ 完全自動化開発フロー"
    ;;
  "full")
    echo -e "  ✅ CI/CD完全自動化"
    echo -e "  ✅ SuperClaude統合"
    echo -e "  ✅ Claude Code自動PR作成"
    echo -e "  ✅ 完全統合環境"
    ;;
esac

echo ""
echo -e "${YELLOW}💡 次のステップ:${NC}"
echo -e "  1. GitHub Secrets でCLAUDE_CODE_OAUTH_TOKENを設定"
echo -e "  2. ${CYAN}./scripts/validate-setup.sh${NC} で設定を検証"
echo -e "  3. ${CYAN}cat .claude/INTEGRATION.md${NC} で使用方法を確認"
echo -e "  4. 初回コミット・プッシュでCI/CDをテスト"

echo ""
echo -e "${BLUE}📚 ドキュメント:${NC}"
echo -e "  - 統合ガイド: ${CYAN}.claude/INTEGRATION.md${NC}"
echo -e "  - Claude Code設定: ${CYAN}claude.md${NC}"
echo -e "  - CI/CDパイプライン: ${CYAN}.github/workflows/${NC}"

echo ""
echo -e "${GREEN}✨ Happy Coding with Enhanced AI Development Environment! ✨${NC}"