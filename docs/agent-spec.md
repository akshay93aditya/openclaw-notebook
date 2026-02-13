# Agent Spec

The agent spec defines how OpenClaw operates your Life OS. The actual spec lives in your vault at `vault/system/agent-spec.md`.

## What It Contains

- **14 slash commands** for quick input routing
- **AI parsing rules** for plain text categorization
- **Task management** with Eisenhower + Impact-Effort prioritization
- **Rollover system** with escalation at 3+ days
- **4 operating modes** (Normal, Travel, Off, Weekend)
- **Autonomy rules** — what the agent can do freely vs. needs confirmation
- **Model routing** — when to use Haiku, Sonnet, or Opus
- **Personality** — how the agent communicates

## Sending to OpenClaw

During initial setup, send the full spec to your Telegram bot. OpenClaw saves it as persistent context (typically at `system/agent-spec.md` in the vault).

See `scripts/onboard-agent.sh` for instructions.

## Modifying

Edit `vault/system/agent-spec.md` directly. Changes take effect on the next interaction. For major changes, re-send the full spec to Telegram to ensure OpenClaw picks up the update.

## Task Syntax Reference

```markdown
- [ ] Standard task
- [ ] With due date 📅 2026-02-14
- [ ] Recurring 🔁 every week 📅 2026-02-14
- [ ] High priority ⏫
- [ ] Medium priority 🔼
- [ ] Low priority 🔽
- [ ] Multi-session ⏳ 2026-02-10 📅 2026-02-14
- [ ] Waiting on someone 🔖waiting 📅 2026-02-15
- [ ] Financial task 💰 📅 2026-02-15
- [x] Completed ✅ 2026-02-09
```

## Subtask Nesting

```markdown
- [ ] Parent task 📅 2026-02-14
    - [ ] Subtask 1
        - context note
    - [ ] Subtask 2
    - notes: preserved as-is
```

Rolling over a parent rolls the entire tree.
