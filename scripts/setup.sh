#!/bin/bash
# OpenClaw Notebook — Setup Wizard
# Run this after cloning the repo to personalize your vault.

set -e

VAULT_DIR="$(cd "$(dirname "$0")/.." && pwd)/vault"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "╔══════════════════════════════════════╗"
echo "║   📓 OpenClaw Notebook Setup         ║"
echo "╚══════════════════════════════════════╝"
echo ""

# Collect info
read -p "Your name: " YOUR_NAME
read -p "Timezone (e.g. Asia/Kolkata, America/New_York): " TIMEZONE
read -p "Timezone short (e.g. IST, EST, PST): " TIMEZONE_SHORT
read -p "UTC offset (e.g. UTC+5:30, UTC-5): " UTC_OFFSET
read -p "Vault path on your Mac (e.g. ~/Documents/openclaw-notebook/vault): " VAULT_PATH

echo ""
echo -e "${YELLOW}Setting up .env file...${NC}"

# Create .env
cat > "$(dirname "$0")/../.env" << EOF
# OpenClaw Notebook Configuration
YOUR_NAME="${YOUR_NAME}"
TIMEZONE="${TIMEZONE}"
TIMEZONE_SHORT="${TIMEZONE_SHORT}"
UTC_OFFSET="${UTC_OFFSET}"
VAULT_PATH="${VAULT_PATH}"

# API Keys (fill these in)
ANTHROPIC_API_KEY=
TELEGRAM_BOT_TOKEN=
EOF

echo -e "${GREEN}✓ Created .env file${NC}"

# Replace placeholders in vault files
echo ""
echo -e "${YELLOW}Replacing placeholders in vault files...${NC}"

find "$VAULT_DIR" -name "*.md" -type f | while read -r file; do
    sed -i.bak \
        -e "s|{{YOUR_NAME}}|${YOUR_NAME}|g" \
        -e "s|{{TIMEZONE}}|${TIMEZONE}|g" \
        -e "s|{{TIMEZONE_SHORT}}|${TIMEZONE_SHORT}|g" \
        -e "s|{{UTC_OFFSET}}|${UTC_OFFSET}|g" \
        -e "s|{{VAULT_PATH}}|${VAULT_PATH}|g" \
        "$file"
    rm -f "${file}.bak"
done

echo -e "${GREEN}✓ Placeholders replaced${NC}"

echo ""
echo "═══════════════════════════════════════"
echo ""
echo -e "${GREEN}Setup complete!${NC} Next steps:"
echo ""
echo "  1. Fill in API keys in .env:"
echo "     - ANTHROPIC_API_KEY from console.anthropic.com"
echo "     - TELEGRAM_BOT_TOKEN from @BotFather"
echo ""
echo "  2. Open vault/ in Obsidian and install plugins"
echo "     See docs/obsidian-setup.md"
echo ""
echo "  3. Install OpenClaw:"
echo "     curl -fsSL https://openclaw.ai/install.sh | bash"
echo "     openclaw onboard --install-daemon"
echo ""
echo "  4. Install skills:"
echo "     npx clawhub install apple-reminders"
echo "     npx clawhub install obsidian"
echo "     brew install gog"
echo ""
echo "  5. Run: ./scripts/setup-crons.sh"
echo ""
echo "  6. Send agent spec to your bot:"
echo "     ./scripts/onboard-agent.sh"
echo ""
echo "  7. Verify: ./scripts/health-check.sh"
echo ""
