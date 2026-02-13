# 📓 OpenClaw Notebook

**A complete personal operating system powered by [OpenClaw](https://openclaw.ai), Obsidian, and AI.**

Turn your Obsidian vault into an intelligent productivity system with an AI agent that manages your tasks, calendar, reminders, and daily notes — all from Telegram.

Built in a single day. Runs for ~$40-80/month.

---

## What It Does

```
You (Telegram, Obsidian, Calendar, Reminders)
        │
        ▼
OpenClaw (AI agent on your Mac)
        │
        ├── 📝 Obsidian vault — tasks, notes, daily logs
        ├── 📅 Google Calendar — time blocks, meetings, deadlines
        ├── ⏰ Apple Reminders — micro-tasks, location triggers, nags
        └── 💬 Telegram — briefings, check-ins, quick capture
        │
        ▼
Daily Note = single source of truth for each day
```

**Message your Telegram bot** → AI parses it → routes to the right place. That's it.

- `/t Buy groceries by 5pm` → task in your daily note + Apple Reminder
- `/n Met with Sarah, discussed pricing` → meeting note in today's log
- `/l https://interesting-article.com` → saved to links inbox
- Or just type naturally — the AI figures it out

## Key Features

- **Morning briefings** — wake up to your prioritized tasks, calendar, and habit status
- **Auto-prioritization** — Eisenhower matrix + impact-effort scoring, no manual sorting
- **Task rollover** — uncompleted tasks carry forward with escalation at 3+ days
- **EOD check-ins** — confirm what's done before rollover (no phantom tasks)
- **Apple Reminders as nagger** — system-level notifications you can't ignore
- **Location reminders** — "remind me to buy dog food near the pet store"
- **Weekly planning** — AI proposes your week, you confirm
- **4 modes** — Normal, Travel, Off, Weekend (auto-detects or manual switch)
- **Shared layer** — shared calendar + reminders with partner
- **Dashboards** — Dataview-powered task views, habit heatmaps, link tracking
- **Everything is markdown** — no vendor lock-in, no hidden databases

## Architecture

```
┌──────────────────────────────────────────────────┐
│           Mac (always-on, or scheduled)           │
│                                                   │
│   OpenClaw Gateway (daemon, auto-starts)          │
│   ├── Telegram bot (your interface)               │
│   ├── Obsidian vault (direct filesystem r/w)      │
│   ├── Google Calendar API (via gog)               │
│   ├── Apple Reminders (native CLI)                │
│   ├── Cron jobs (scheduled automations)           │
│   └── Heartbeat (background monitoring)           │
│                                                   │
│   Obsidian Vault (git repo, local files)          │
└──────────────────────────┬───────────────────────┘
                           │ Git sync (5 min)
            ┌──────────────┴──────────────┐
            │  Other devices (optional)    │
            │  Obsidian + Git              │
            │  Working Copy on iOS         │
            └─────────────────────────────┘
```

## Cost

| Item | Cost |
|------|------|
| Anthropic API (Haiku/Sonnet/Opus) | ~$40-80/mo |
| Obsidian | Free |
| Git sync | Free |
| Working Copy (iOS, optional) | $20 one-time |
| Google Calendar | Free |
| Apple Reminders | Free |
| Telegram | Free |
| OpenClaw | Free (open source) |

**Cost optimization is built in.** Three-tier model routing (Haiku for simple ops, Sonnet for interactions, Opus on-demand only) keeps costs ~55-65% lower than running everything on Opus.

---

## Quick Start

### Prerequisites

- macOS (Mac Mini, MacBook, or any always-on Mac)
- [Obsidian](https://obsidian.md) installed
- [Node.js](https://nodejs.org) ≥ 22
- [Homebrew](https://brew.sh)
- Anthropic API key ([console.anthropic.com](https://console.anthropic.com))
- Telegram account

### 1. Clone & Configure

```bash
cd ~/Documents
git clone https://github.com/YOUR_USERNAME/openclaw-notebook.git
cd openclaw-notebook
```

Run the setup wizard:

```bash
./scripts/setup.sh
```

This will walk you through:
- Setting your name, timezone, schedule
- Replacing template placeholders with your details
- Creating your `.env` file with API keys

### 2. Open in Obsidian

Open the `vault/` folder as an Obsidian vault. Install the required plugins:

| Plugin | Purpose |
|--------|---------|
| Templater | Dynamic daily note generation |
| Periodic Notes | Auto-create daily/weekly notes |
| Tasks | Due dates, recurrence, priority |
| Dataview | Dashboards and queries |
| Obsidian Git | Free sync via GitHub |
| Calendar | Sidebar calendar UI |
| Heatmap Calendar | Habit tracking visualization |
| Rollover Daily Todos | Auto-carry undone tasks |
| Reminder | In-Obsidian notifications |

See [docs/obsidian-setup.md](docs/obsidian-setup.md) for detailed plugin settings.

### 3. Install OpenClaw

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
openclaw onboard --install-daemon
```

Install required skills:

```bash
npx clawhub install apple-reminders
npx clawhub install obsidian
brew install gog  # Google Calendar
```

> ⚠️ **Gotcha:** API key goes in the `env` section of `openclaw.json`, not in auth profile. See [docs/gotchas.md](docs/gotchas.md).

### 4. Set Up Telegram Bot

1. Message [@BotFather](https://t.me/BotFather) on Telegram
2. Create a new bot, save the token
3. Add the token during OpenClaw onboarding

### 5. Set Up Calendar & Reminders

```bash
./scripts/setup-calendar.sh   # Creates Google Calendar sub-calendars
./scripts/setup-reminders.sh  # Creates Apple Reminders lists
```

### 6. Feed Context to OpenClaw

Send the agent spec to your bot:

```bash
./scripts/onboard-agent.sh
```

This sends your system files (schedule, habits, recurring tasks, autonomy rules) to OpenClaw so it knows how to operate.

### 7. Set Up Cron Jobs

```bash
./scripts/setup-crons.sh
```

This configures all scheduled automations (morning briefing, EOD check-in, weekly review, etc.)

### 8. Test

```bash
./scripts/health-check.sh
```

Verifies: OpenClaw running, Telegram connected, calendar accessible, reminders working, git syncing.

---

## Documentation

| Doc | What It Covers |
|-----|----------------|
| [Setup Guide](docs/setup-guide.md) | Complete step-by-step walkthrough |
| [Obsidian Setup](docs/obsidian-setup.md) | Plugin installation and configuration |
| [Agent Spec](docs/agent-spec.md) | How the AI agent behaves, commands, parsing |
| [Cron Jobs](docs/cron-jobs.md) | All scheduled automations explained |
| [Cost Guide](docs/cost-guide.md) | Model routing, optimization, cost calculator |
| [Gotchas](docs/gotchas.md) | Everything that can go wrong (and fixes) |
| [Customization](docs/customization.md) | How to adapt for your workflow |

---

## Slash Commands

| Command | What It Does |
|---------|-------------|
| `/t Buy groceries by 5pm` | Add task (auto-routes: micro → Reminders, else → daily note) |
| `/t! Call the bank NOW` | Urgent micro-task → immediate Reminder nag |
| `/n Met with Sarah, discussed X` | Meeting note → daily note |
| `/n! Business idea: AI for Y` | Note + auto-create linked page |
| `/l https://article.com` | Save link → daily note + Links/Inbox |
| `/j Feeling good about progress` | Journal entry → daily note |
| `/p project-name: Do the thing` | Project task → under that project |
| `/h exercise` | Mark habit done |
| `/today` | Resend today's briefing |
| `/week` | This week's status |
| `/travel` or `/travel Feb 12-14` | Activate travel mode |
| `/off` or `/off Feb 15-22` | Activate vacation mode |
| `/done [task text]` | Mark task complete everywhere |
| Plain text | AI parses and routes automatically |

---

## How It's Different

Most "productivity systems" are either a template pack you fill manually, or a SaaS tool you don't own.

This is **an AI agent that actually operates on your system.** It reads your vault, manages your calendar, nags you via native notifications, and talks to you on Telegram. And you own every file — it's all local markdown and git.

---

## Built With

- [OpenClaw](https://openclaw.ai) — Local AI agent framework
- [Obsidian](https://obsidian.md) — Knowledge base
- [Anthropic Claude](https://anthropic.com) — AI models (Haiku/Sonnet/Opus)
- Google Calendar + Apple Reminders + Telegram

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. Issues and PRs welcome.

## License

MIT — see [LICENSE](LICENSE).

---

*Built in a day. Runs your life thereafter.*
