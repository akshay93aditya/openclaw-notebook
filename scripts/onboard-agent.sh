#!/bin/bash
# OpenClaw Notebook — Onboard Agent
# Sends the agent spec to OpenClaw via Telegram for persistent context.

set -e

SPEC_FILE="$(cd "$(dirname "$0")/.." && pwd)/vault/system/agent-spec.md"

if [ ! -f "$SPEC_FILE" ]; then
    echo "❌ Agent spec not found at $SPEC_FILE"
    echo "   Run ./scripts/setup.sh first."
    exit 1
fi

echo ""
echo "Sending agent spec to OpenClaw..."
echo ""
echo "This sends your system/agent-spec.md to the Telegram bot."
echo "OpenClaw will save it for persistent reference."
echo ""
echo "Instructions:"
echo "  1. Open your Telegram bot"
echo "  2. Copy-paste the contents of vault/system/agent-spec.md"
echo "  3. Send it with the prefix: 'ONBOARDING SPEC — save this as your operating manual:'"
echo "  4. OpenClaw will confirm it's saved"
echo ""
echo "Alternatively, if openclaw CLI supports direct message:"
echo "  openclaw send --message \"$(cat "$SPEC_FILE")\""
echo ""
echo "After onboarding, test with: /today"
echo ""
