#!/bin/bash
# OpenClaw Notebook — Health Check
# Verifies all components are running correctly.

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "╔══════════════════════════════════════╗"
echo "║   🏥 Health Check                    ║"
echo "╚══════════════════════════════════════╝"
echo ""

PASS=0
FAIL=0

check() {
    if eval "$2" > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} $1"
        ((PASS++))
    else
        echo -e "  ${RED}✗${NC} $1"
        ((FAIL++))
    fi
}

echo "Core Services:"
check "OpenClaw running" "pgrep -f openclaw"
check "Node.js ≥22" "node -v | grep -E 'v2[2-9]|v[3-9]'"
check "Git installed" "git --version"
check "gog installed" "which gog"

echo ""
echo "Vault:"
check "Vault directory exists" "test -d '${VAULT_PATH:-vault}'"
check "Git repo initialized" "test -d '${VAULT_PATH:-vault}/.git'"
check "Templates present" "test -f '${VAULT_PATH:-vault}/templates/daily-note.md'"
check "System files present" "test -f '${VAULT_PATH:-vault}/system/agent-spec.md'"
check "Dashboards present" "test -f '${VAULT_PATH:-vault}/dashboards/task-dashboard.md'"

echo ""
echo "OpenClaw:"
check "Skills: obsidian" "openclaw skill list 2>&1 | grep -i obsidian"
check "Skills: apple-reminders" "openclaw skill list 2>&1 | grep -i apple-reminders"
check "Skills: gog" "which gog"
check "Cron jobs configured" "openclaw cron list 2>&1 | grep morning-setup"

echo ""
echo "════════════════════════════════════════"
echo -e "  ${GREEN}Passed: $PASS${NC}  ${RED}Failed: $FAIL${NC}"
echo ""

if [ $FAIL -gt 0 ]; then
    echo -e "${YELLOW}Some checks failed. See docs/gotchas.md for common fixes.${NC}"
fi
echo ""
