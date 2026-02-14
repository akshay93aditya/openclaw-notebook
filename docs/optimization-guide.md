# Optimization Guide

Advanced optimizations for reducing costs and improving performance after initial setup.

---

## Cost Optimization

### Bootstrap Size Management

OpenClaw injects bootstrap files (agent-spec.md, AGENTS.md, HEARTBEAT.md, etc.) at the start of every API call. These count as input tokens.

**Critical config:**
```bash
openclaw config set agents.defaults.bootstrapMaxChars 25000
```

**Why this matters:**
- If set too low (e.g., 12,000), your agent-spec.md gets truncated
- Truncated spec = model doesn't see full routing logic
- Missing logic = clarifying questions, mis-routing, Opus escalations
- Result: Higher costs from wasted tokens and expensive model usage

**Recommended:** 25,000 characters minimum. Your agent-spec.md is ~11-13K bytes, and other bootstrap files add up.

### Cron Consolidation

**Default setup has 10+ cron jobs. Consider consolidating:**

**Good candidates for merging:**
- **task-rollover + eod-checkin**: Both run end-of-day, 30 min apart. Merge into single 11PM job: metadata hygiene → task check → rollover → git commit.
- **weekly-calendar + weekly-review**: Both run Sunday evening. Merge: review week → plan next week.
- **personal-dates check**: If checking daily, move to weekly review. Dates don't change daily; 7-day granularity with 14-day lead time is sufficient.

**Low-value crons to consider removing:**
- **gap-detector**: If running every 30min (26 calls/day), consider disabling or reducing to 2-3 times daily. "You have a calendar gap" nudges are low-value for high frequency.
- **link-followup**: If you also have link-deadline reminder, the follow-up may be redundant.
- **recurring task generators**: If tasks are already in `system/recurring-tasks.md` and handled by morning briefing, separate crons may be redundant.

**Each cron consolidation saves:**
- 1 fewer Sonnet/Haiku call per day/week
- 18-25K input tokens (bootstrap) per eliminated call
- Example: Removing gap-detector (26 calls/day on Haiku) saves ~$3-4/month

### Model Routing from Cheap Models

**GPT-5-mini ($0.25/$2 per MTok) and GPT-5-nano ($0.05/$0.40 per MTok) are tempting but:**
- They don't follow the agent-spec reliably
- They hallucinate tool calls
- They ask unnecessary clarifying questions
- Result: User frustration + wasted tokens

**Recommendation:**
- Use **Haiku** for simple, deterministic tasks (heartbeats, file counts, basic checks)
- Use **Sonnet** for anything requiring agent-spec adherence
- Only use cheap models if the task is truly trivial (e.g., "count files in links/inbox and send number to Telegram")

### Zero Opus in Steady State

**Opus is 5x Sonnet's output cost** ($15/$75 vs $3/$15 per MTok).

The agent-spec already requires the bot to ask before escalating to Opus. In normal operations, Opus should appear **never** or **rarely** (complex planning, debugging only).

**If you see frequent Opus usage:**
1. Check if bootstrap is truncated (see Bootstrap Size above)
2. Review agent-spec for unclear instructions
3. Check if recurring tasks are properly defined

---

## Performance Optimization

### Git Sync

**Don't run git sync in heartbeat if using Obsidian Git plugin.**

Obsidian Git can auto-commit every 5 minutes. Running git commands in heartbeat adds unnecessary compute.

**Heartbeat should only:**
- Monitor calendar for upcoming events
- Sync Apple Reminders status
- Check for vault changes (read-only)

### Heartbeat Frequency

**Default: Every 2 hours** is fine for most users.

Reduce frequency if:
- You don't need real-time calendar monitoring
- Apple Reminders sync can be delayed
- You're on a tight budget

**Don't go below 4 hours** unless you're comfortable with delayed calendar notifications.

### Bootstrap File Trimming

After onboarding, review your bootstrap files and remove unused content:

**Files to trim:**
- `AGENTS.md`: Remove examples for tools you don't use (Discord, WhatsApp, camera, TTS, SSH)
- `SOUL.md`: Remove generic personality fluff that overlaps with agent-spec
- `TOOLS.md`: Remove empty template sections

**Files to never edit:**
- `IDENTITY.md`: Core user info
- `MEMORY.md`: Session learnings
- `HEARTBEAT.md`: System monitoring config

**Savings:** Every 1,000 bytes removed = ~250 tokens saved per API call. With 50 API calls/month, that's 12,500 tokens/month (~$0.15-0.20 savings per 1K bytes removed).

---

## Quality vs. Cost Trade-offs

### What NOT to Optimize

**Don't reduce quality for minimal savings:**

1. **Morning briefing**: This is your daily command center. Keep it on Sonnet.
2. **EOD check-in**: Interactive task review requires Sonnet's reasoning.
3. **Weekly review**: Strategic planning needs Sonnet.
4. **Agent-spec completeness**: Don't trim the spec to save tokens. A truncated spec costs more in mis-routing.

### Safe Optimizations (Zero Quality Loss)

1. **Cron consolidation** (see above)
2. **Bootstrap trimming** (remove unused examples only)
3. **Gap detector removal** (if low-value for you)
4. **Slash command usage** (faster parsing than plain text)

---

## Monitoring & Debugging

### Check Current Config

```bash
openclaw config get agents.defaults.bootstrapMaxChars
openclaw config get agents.defaults.contextTokens
```

### Check Bootstrap Size

```bash
# In your vault root
du -sh AGENTS.md SOUL.md TOOLS.md system/agent-spec.md HEARTBEAT.md IDENTITY.md MEMORY.md USER.md 2>/dev/null | awk '{sum+=$1} END {print sum}'
```

Should be under 25,000 bytes total.

### Check Cron Status

```bash
openclaw cron list
openclaw cron runs --id <cron-uuid> --limit 5
```

### Monitor API Costs

- Console: [console.anthropic.com](https://console.anthropic.com) → Usage
- Set budget alerts to catch cost spikes early

---

## Cost Breakdown (After Optimization)

| Component | Frequency | Model | Est. Monthly Cost |
|-----------|-----------|-------|-------------------|
| Morning briefing | 30x/month | Sonnet | ~$2-3 |
| EOD check-in (merged) | 30x/month | Sonnet | ~$2-3 |
| Weekly review (merged) | 4x/month | Sonnet | ~$0.50 |
| Link deadline | 4x/month | Haiku | ~$0.10 |
| Heartbeat | 360x/month | Nano | ~$0.02 |
| **Subtotal (automated)** | | | **~$5-7** |
| Telegram interactions | 10-20/day | Sonnet | ~$12-18 |
| **Total** | | | **~$17-25/month** |

**Key driver:** 70% of cost is Telegram interactions. Each message sends 18-25K bootstrap + conversation context.

**Future optimization:** Anthropic prompt caching (when supported in OpenClaw) would save ~90% on repeated bootstrap = total cost → ~$7-10/month.

---

## Quick Wins Checklist

- [ ] Set `bootstrapMaxChars` to 25,000+
- [ ] Merge task-rollover into eod-checkin
- [ ] Merge weekly-calendar into weekly-review
- [ ] Move personal-dates check to weekly review
- [ ] Remove gap-detector if running more than 4x/day
- [ ] Trim AGENTS.md, SOUL.md, TOOLS.md (remove unused examples)
- [ ] Verify no Opus usage in normal operations
- [ ] Set budget alert at console.anthropic.com
- [ ] Use slash commands over plain text when possible

**Expected savings:** $15-20/month → $17-25/month with zero quality degradation.
