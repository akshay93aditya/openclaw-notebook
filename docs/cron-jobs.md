# Cron Jobs

All scheduled automations that run in the background.

---

## Daily

| Job | Time | Model | What It Does |
|-----|------|-------|-------------|
| morning-setup | 8:00 AM | Sonnet | Creates daily note + sends Telegram briefing |
| gap-detector | 12, 3, 7, 10 PM (weekdays) | Haiku | Nudges if calendar gaps + uncleared links |
| eod-checkin | 11:00 PM | Sonnet | Interactive: lists uncompleted tasks, asks what's done |
| task-rollover | 11:30 PM | Sonnet | Rolls tasks forward, escalates at 3+ days |
| personal-dates | 9:00 AM | Haiku | Checks for upcoming important dates |

## Weekly

| Job | Time | Model | What It Does |
|-----|------|-------|-------------|
| link-deadline | Friday 6:00 PM | Haiku | Reminds about uncleared links |
| link-followup | Monday 9:00 AM | Haiku | Follows up on last week's links |
| weekly-review | Sunday 7:00 PM | Sonnet | Interactive review via Telegram |
| weekly-calendar | Sunday 8:00 PM | Sonnet | Proposes next week's schedule |

## Managing Crons

```bash
# List all crons
openclaw cron list

# Remove a cron
openclaw cron remove --name "job-name"

# Manually trigger a cron for testing
openclaw cron trigger --name "morning-setup"
```

## Customizing

Edit `scripts/setup-crons.sh` and re-run it. Key things to adjust:
- **Times** — match your timezone and wake/sleep schedule
- **Gap detector frequency** — reduce if too noisy
- **Model tier** — switch Haiku jobs to Sonnet if quality is too low

## Adding Custom Crons

```bash
openclaw cron add --name "my-custom-job" \
  --cron "0 14 * * 1-5" --tz "Your/Timezone" \
  --message "Your prompt here"
```
