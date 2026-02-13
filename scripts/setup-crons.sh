#!/bin/bash
# OpenClaw Notebook — Cron Jobs Setup
# Sets up all scheduled automations.

set -e

# Load config
if [ -f "$(dirname "$0")/../.env" ]; then
    source "$(dirname "$0")/../.env"
else
    echo "❌ .env not found. Run ./scripts/setup.sh first."
    exit 1
fi

TZ="${TIMEZONE:-Asia/Kolkata}"

echo ""
echo "Setting up cron jobs (timezone: $TZ)..."
echo ""

# Morning setup — combined daily note creation + briefing
openclaw cron add --name "morning-setup" \
  --cron "0 8 * * *" --tz "$TZ" \
  --message "Create today's daily note from template (travel template if travel mode). Pull calendar events with timezone conversions. Insert rolled-over tasks with markers. Add recurring tasks. Process bot-queue. Send morning briefing via Telegram. Commit to git. Reference system/agent-spec.md for all rules."

# EOD check-in
openclaw cron add --name "eod-checkin" \
  --cron "0 23 * * *" --tz "$TZ" \
  --message "Scan today's daily note for uncompleted tasks. Send numbered list via Telegram. Ask which are done. Mark confirmed done. Increment rollover counters. Escalate at 3+ days. Nudge if journal empty. Commit to git."

# Task rollover
openclaw cron add --name "task-rollover" \
  --cron "30 23 * * *" --tz "$TZ" \
  --message "Prepare rolled-over tasks for tomorrow. Preserve full subtask trees. Send escalation alerts for 3+ day tasks via Telegram (options: reschedule, drop, keep, break into subtasks)."

# Gap detector — 4x/day on weekdays
openclaw cron add --name "gap-detector" \
  --cron "0 12,15,19,22 * * 1-5" --tz "$TZ" \
  --message "Check calendar for gaps ≥20 min in next 2 hours. If uncleared links or incomplete reading notes exist, send Telegram nudge. Skip if travel or off mode."

# Personal dates checker
openclaw cron add --name "personal-dates" \
  --cron "0 9 * * *" --tz "$TZ" \
  --message "Check personal/relationship/important-dates.md for anything within 14 days. Create prep tasks. Send Telegram notification."

# Link clearing deadline — Friday
openclaw cron add --name "link-deadline" \
  --cron "0 18 * * 5" --tz "$TZ" \
  --message "Count uncleared items in links/inbox/. Send Telegram reminder with count."

# Link follow-up — Monday
openclaw cron add --name "link-followup" \
  --cron "0 9 * * 1" --tz "$TZ" \
  --message "If links/inbox still has items from last week, send Telegram follow-up."

# Weekly review — Sunday 7 PM
openclaw cron add --name "weekly-review" \
  --cron "0 19 * * 0" --tz "$TZ" \
  --message "Interactive weekly review via Telegram. Cover: habit rates, completed tasks, overdue items, links status, project status. Ask reflections. Save to weekly-reviews folder."

# Weekly calendar — Sunday 8 PM
openclaw cron add --name "weekly-calendar" \
  --cron "0 20 * * 0" --tz "$TZ" \
  --message "Read system/meta-structure.md for schedule. Check next week's calendar. Read open tasks with due dates. Apply prioritization. Propose weekly schedule via Telegram. Wait for confirmation before creating events."

echo ""
echo "✅ All cron jobs configured!"
echo ""
echo "Verify with: openclaw cron list"
echo ""
