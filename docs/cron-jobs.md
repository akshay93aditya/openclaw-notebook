# Cron Jobs

All scheduled automations that run in the background.

---

## Daily

| Job | Time | Model | What It Does |
|-----|------|-------|-------------|
| morning-setup | 8:00 AM | Sonnet | Creates daily note + sends briefing (merged — saves a Sonnet call vs. running separately) |
| gap-detector | 12, 3, 7, 10 PM (weekdays) | Haiku | Nudges if calendar gaps + uncleared links (4x/day, not every 30 min — cost optimized) |
| eod-checkin | 11:00 PM | Sonnet | Interactive: lists uncompleted tasks, asks what's done, does metadata hygiene |
| task-rollover | 11:30 PM | Sonnet | Rolls tasks forward, escalates at 3+ days |
| personal-dates | 9:00 AM | Haiku | Checks for upcoming important dates |

## Weekly

| Job | Time | Model | What It Does |
|-----|------|-------|-------------|
| link-deadline | Friday 6:00 PM | Haiku | Reminds about uncleared links |
| link-followup | Monday 9:00 AM | Haiku | Follows up on last week's links |
| weekly-review | Sunday 7:00 PM | Sonnet | Interactive review via Telegram |
| weekly-calendar | Sunday 8:00 PM | Sonnet | Proposes next week's schedule |
| project-social-media | Monday 9:00 AM | Haiku | Creates weekly blog/social recurring tasks |

## One-Shot Items

**Important rule:** Never create one-shot cron jobs. Route one-time items to:
- Daily note (task with a due date)
- Apple Reminders (micro-task with a time/date)
- Google Calendar Deadlines (important date)

Cron is ONLY for recurring automations.

## Managing Crons

```bash
# List all crons
openclaw cron list

# Remove a cron
openclaw cron remove --name "job-name"

# Manually trigger a cron for testing
openclaw cron trigger --name "morning-setup"

# Edit a cron (change model, schedule, etc.)
openclaw cron edit <uuid> --model anthropic/claude-sonnet-4-5
```

## Customizing

Edit `scripts/setup-crons.sh` and re-run it. Key things to adjust:
- **Times**: Match your timezone and wake/sleep schedule
- **Gap detector frequency**: Reduce if too noisy (default 4x/day weekdays)
- **Model tier**: Switch Haiku jobs to Sonnet if quality is too low

## Optimization Tips

**Consider consolidating crons to reduce costs:**

- **task-rollover + eod-checkin**: Both run end-of-day. Merge into single 11PM job.
- **weekly-calendar + weekly-review**: Both run Sunday evening. Combine the planning.
- **personal-dates**: If checking daily, move to weekly review. Dates don't change daily.

**Each cron costs:**
- Haiku: ~$0.01-0.02 per run (bootstrap + execution)
- Sonnet: ~$0.05-0.10 per run

**Gap detector at 4x/day = 120 calls/month.** Consider reducing frequency or removing if low-value.

See [docs/optimization-guide.md](optimization-guide.md) for detailed cost optimization strategies.

## Adding Custom Crons

```bash
openclaw cron add --name "my-custom-job" \
  --cron "0 14 * * 1-5" --tz "Your/Timezone" \
  --message "Your prompt here"
```
