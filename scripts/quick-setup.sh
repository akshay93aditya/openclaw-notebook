#!/bin/bash
# Quick Setup - Simplified single-command setup
# This combines all setup steps into one script with smart defaults

set -e

VAULT_DIR="$(cd "$(dirname "$0")/.." && pwd)/vault"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   📓 OpenClaw Notebook Quick Setup         ║"
echo "║   One-command installation                 ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Step 1: Basic Configuration
echo -e "${BLUE}Step 1/6: Basic Configuration${NC}"
echo ""
read -p "Your name: " YOUR_NAME
read -p "Timezone (e.g. America/New_York, Asia/Kolkata): " TIMEZONE
read -p "Timezone short (e.g. EST, IST): " TIMEZONE_SHORT
read -p "UTC offset (e.g. UTC-5, UTC+5:30): " UTC_OFFSET

VAULT_PATH="$(cd "$(dirname "$0")/.." && pwd)/vault"

echo ""
echo -e "${YELLOW}Creating .env file...${NC}"
cat > "$(dirname "$0")/../.env" << EOF
# OpenClaw Notebook Configuration
YOUR_NAME="${YOUR_NAME}"
TIMEZONE="${TIMEZONE}"
TIMEZONE_SHORT="${TIMEZONE_SHORT}"
UTC_OFFSET="${UTC_OFFSET}"
VAULT_PATH="${VAULT_PATH}"

# API Keys
ANTHROPIC_API_KEY=
TELEGRAM_BOT_TOKEN=
EOF

# Replace placeholders
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

echo -e "${GREEN}✓ Configuration complete${NC}"
echo ""

# Step 2: Prerequisites Check
echo -e "${BLUE}Step 2/6: Checking Prerequisites${NC}"
echo ""

# Check for required tools
command -v node >/dev/null 2>&1 || { echo -e "${RED}✗ Node.js not found. Install from https://nodejs.org${NC}"; exit 1; }
command -v brew >/dev/null 2>&1 || { echo -e "${RED}✗ Homebrew not found. Install from https://brew.sh${NC}"; exit 1; }

echo -e "${GREEN}✓ Node.js found: $(node --version)${NC}"
echo -e "${GREEN}✓ Homebrew found${NC}"
echo ""

# Step 3: OpenClaw Installation
echo -e "${BLUE}Step 3/6: Installing OpenClaw${NC}"
echo ""

if command -v openclaw >/dev/null 2>&1; then
    echo -e "${GREEN}✓ OpenClaw already installed${NC}"
else
    echo "Installing OpenClaw..."
    curl -fsSL https://openclaw.ai/install.sh | bash
    export PATH="$HOME/.openclaw/bin:$PATH"
fi

echo ""
echo -e "${YELLOW}Installing OpenClaw skills...${NC}"
npx clawhub install apple-reminders
npx clawhub install obsidian

echo ""
echo -e "${YELLOW}Installing Google Calendar CLI...${NC}"
brew install gog

echo -e "${GREEN}✓ OpenClaw and skills installed${NC}"
echo ""

# Step 4: API Keys
echo -e "${BLUE}Step 4/6: API Keys${NC}"
echo ""
echo "You need:"
echo "  1. Anthropic API key from https://console.anthropic.com"
echo "  2. Telegram bot token from @BotFather on Telegram"
echo ""
read -p "Anthropic API key: " ANTHROPIC_API_KEY
read -p "Telegram bot token: " TELEGRAM_BOT_TOKEN

# Update .env
cat > "$(dirname "$0")/../.env" << EOF
# OpenClaw Notebook Configuration
YOUR_NAME="${YOUR_NAME}"
TIMEZONE="${TIMEZONE}"
TIMEZONE_SHORT="${TIMEZONE_SHORT}"
UTC_OFFSET="${UTC_OFFSET}"
VAULT_PATH="${VAULT_PATH}"

# API Keys
ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
TELEGRAM_BOT_TOKEN=${TELEGRAM_BOT_TOKEN}
EOF

echo -e "${GREEN}✓ API keys configured${NC}"
echo ""

# Step 5: Calendar & Reminders
echo -e "${BLUE}Step 5/6: Calendar & Reminders Setup${NC}"
echo ""
echo "Opening setup scripts..."
echo ""

echo -e "${YELLOW}Setting up Google Calendar...${NC}"
./setup-calendar.sh

echo ""
echo -e "${YELLOW}Setting up Apple Reminders...${NC}"
./setup-reminders.sh

echo -e "${GREEN}✓ Calendar and Reminders configured${NC}"
echo ""

# Step 6: Finalize
echo -e "${BLUE}Step 6/6: Finalizing Setup${NC}"
echo ""

echo -e "${YELLOW}Onboarding agent...${NC}"
./onboard-agent.sh

echo ""
echo -e "${YELLOW}Setting up cron jobs...${NC}"
./setup-crons.sh

echo ""
echo -e "${YELLOW}Running health check...${NC}"
./health-check.sh

echo ""
echo "═══════════════════════════════════════════════"
echo ""
echo -e "${GREEN}✓ Quick Setup Complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open vault/ in Obsidian"
echo "  2. Install the required plugins (see docs/obsidian-setup.md)"
echo "  3. Send /today to your Telegram bot to test"
echo ""
echo "Documentation: docs/setup-guide.md"
echo ""
