# 📓 OpenClaw Notebook

An AI-powered personal OS that keeps your notes, calendar, and reminders perpetually in sync.

Built on [OpenClaw](https://openclaw.ai), Obsidian, Google Calendar, Apple Reminders, and Telegram.

> **Full disclosure:** I didn't write any code for this. I supervised [Claude Code](https://claude.ai/code) while it built the entire thing — every script, every config, every integration. If this helps you, [buy me a coffee ☕](https://buymeacoffee.com/akshay93aditya)

---

## Why I Built This

I've tried every productivity tool out there. And my biggest problem with all of them is that they are optimized for use only inside *their* interface.

Some are great calendars but terrible note-takers. Some are great note-takers but terrible task managers. And most "all-in-one" tools are mediocre at everything. So I end up using 3-4 different apps, and that means having duplicate tasks, conflicting calendars, and things falling through the cracks. The inefficiency of this drives me insane.

Here's what I actually use:
- **Obsidian** for notes. It's the smoothest, most flexible tool out there. But it's rough on mobile, and I can't quickly capture things on the go.
- **Notion Calendar** for calendar. I like the UI (I just liked Cron and have never switched. RIP). But it's bad at quick edits and terrible at giving repeated nudges for small tasks.
- **Apple Reminders** for micro-tasks. iOS system-level notifications are unbeatable. But it doesn't talk to anything else.

The way I see it: my notes, my reminders, and my calendar should be **perpetually in sync**. I should be able to enter or edit anything from anywhere and the system should just figure it out. Tasks should self-sort. Reminders should auto-fire. Calendar blocks should auto-schedule. And I shouldn't have to babysit any of it.
And I have seen the tools that offer some versions of this, but again; they are close to what I want, not EXACTLY what I want. I don't mind paying the $20/mo for this stuff, it's that I pay the $20 and I am still getting a tool that does not do exactly what I want the way I want it.

So I built this. OpenClaw Notebook.

**Obsidian** is the note-taker and task manager. **Telegram** is the quick-capture interface (solves the mobile problem entirely). **Google Calendar** is the calendar (I use Notion Calendar as the UI layer). **Apple Reminders** is the nagger. And **OpenClaw** is the nervous system that connects everything: it checks, aligns, routes, and syncs across all of them.

I know there are a thousand personal assistants built on OpenClaw. This is just the one that works for me. Maybe it works for you too.

---

## How It Works

```
You (Telegram, Obsidian, Calendar, Reminders)
        │
        ▼
OpenClaw (AI agent running on your Mac)
        │
        ├── 📝 Obsidian: tasks, notes, daily logs
        ├── 📅 Google Calendar: time blocks, meetings
        ├── ⏰ Apple Reminders: micro-tasks, nags
        └── 💬 Telegram: briefings, quick capture
        │
        ▼
Daily Note = single source of truth
```

Everything flows into your daily note. Whether you type it in Obsidian, message your Telegram bot, add a calendar event, or check off a reminder, it all ends up in that day's note. Dashboards query daily notes. Weekly reviews aggregate from them. No separate database.

### What happens automatically

- **8 AM:** Morning briefing on Telegram with your prioritized tasks, calendar, and habits
- **Throughout the day:** Tasks auto-sort using Eisenhower matrix + impact-effort scoring
- **During work:** Nudges if you have calendar gaps and uncleared links
- **11 PM:** Bot asks which uncompleted tasks are actually done (prevents phantom rollover)
- **11:30 PM:** Remaining tasks roll to tomorrow. At 3+ days, you get an alert to reschedule or drop
- **Sunday evening:** AI proposes next week's schedule, you confirm, calendar blocks created

Plus: micro-tasks (≤15 min like phone calls, bookings) go straight to Apple Reminders with aggressive nag cycles. Bigger tasks stay in your daily note.

### Using it from Telegram

Just message your bot. Examples:

- `/t Buy groceries by 5pm` → task (routes to Reminders if quick, daily note if not)
- `/t! Call the bank NOW` → urgent reminder that nags immediately
- `/n Met with Sarah, discussed pricing` → meeting note
- `/l https://article.com` → saves to links inbox
- `/j Feeling good about progress` → journal entry
- `/h exercise` → marks habit done
- `/today` → resends your briefing
- Or just type naturally, Claude figures it out

**4 modes:** Normal (full automation), Travel (must-dos only), Off (personal only), Weekend (unstructured). Switch with `/travel` or `/off`, or it auto-detects.

---

## The Stack

```
Mac (always-on or scheduled wake)
├── OpenClaw daemon (auto-starts on boot)
│   ├── Telegram bot
│   ├── Sonnet for 95% of interactions
│   ├── Haiku for simple file ops
│   ├── Opus only when needed (asks first)
│   └── 10 cron jobs for automations
├── Obsidian vault (git repo, all markdown)
├── Google Calendar (4 sub-calendars)
├── Apple Reminders (4-6 lists)
└── Notion Calendar (optional UI)

Syncs: Mac ↔ GitHub ↔ other devices
```

**Everything is markdown.** No databases or external vendors. You own every file.

I use git for syncing. There's a slight delay (~1-5 min) but it's fine. You can pay for Obsidian Sync if you want instant, but I'm minimizing costs. On iOS, Working Copy ($20 one-time) handles git. I don't use Obsidian on mobile; Telegram does everything I need.

---

## Cost

| What | Cost |
|------|------|
| Anthropic API (setup) | ~$20 one-time |
| Anthropic API (monthly) | ~$10-20/mo *(still optimizing)* |
| Everything else | Free |

Claude Max doesn't cover this; it's pay-per-use API at [console.anthropic.com](https://console.anthropic.com).

Three-tier model routing keeps costs down: Haiku ($1/1M tokens) for simple ops, Sonnet ($3/1M) for interactions, Opus ($15/1M) only when you need it. About 55-65% cheaper than running everything on one model.

---

## Setup

**You'll need:**
- macOS (Mac Mini or MacBook, needs to stay on or wake on schedule)
- [Obsidian](https://obsidian.md)
- [Node.js](https://nodejs.org) ≥ 22
- [Homebrew](https://brew.sh)
- Anthropic API key from [console.anthropic.com](https://console.anthropic.com)
- Telegram account

### Quick Setup (Recommended)

One command does everything:

```bash
cd ~/Documents
git clone https://github.com/akshay93aditya/openclaw-notebook.git
cd openclaw-notebook
chmod +x scripts/*.sh
./scripts/quick-setup.sh
```

This runs all setup steps in order. Or follow the manual steps below:

### Manual Setup

#### 1. Clone and configure

```bash
cd ~/Documents
git clone https://github.com/akshay93aditya/openclaw-notebook.git
cd openclaw-notebook
chmod +x scripts/*.sh
./scripts/setup.sh
```

The setup wizard asks for your name, timezone, and schedule. It replaces all the template placeholders.

#### 2. Set up Obsidian

Open `vault/` as an Obsidian vault. Install these plugins:

- **Templater**: dynamic daily notes
- **Periodic Notes**: auto-create daily/weekly notes
- **Tasks**: due dates, recurrence, priority
- **Dataview**: dashboards
- **Obsidian Git**: free GitHub sync
- **Calendar**: sidebar UI
- **Heatmap Calendar**: habit visualization
- **Rollover Daily Todos**: carry tasks forward
- **Reminder**: in-app notifications

See [docs/obsidian-setup.md](docs/obsidian-setup.md) for settings.

#### 3. Install OpenClaw

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
openclaw onboard --install-daemon

npx clawhub install apple-reminders
npx clawhub install obsidian
brew install gog  # Google Calendar CLI
```

**Important:** Your API key goes in the `env` section of `openclaw.json`, NOT the auth profile. Read [docs/gotchas.md](docs/gotchas.md) first to save yourself headaches.

#### 4. Telegram bot

Message [@BotFather](https://t.me/BotFather) on Telegram, create a bot, save the token. Add it during OpenClaw onboarding.

#### 5. Calendar and Reminders

```bash
./scripts/setup-calendar.sh   # Creates Google Calendar sub-calendars
./scripts/setup-reminders.sh  # Creates Apple Reminders lists
```

Follow the prompts to create your calendar structure.

#### 6. Wire it up

```bash
./scripts/onboard-agent.sh  # Sends agent spec to your bot
./scripts/setup-crons.sh    # Sets up all automations
./scripts/health-check.sh   # Verifies everything works
```

Test: send `/today` to your bot. You should get a briefing.

Full guide: [docs/setup-guide.md](docs/setup-guide.md)

---

## The Vault

```
vault/
├── daily-notes/          # One file per day, center of everything
├── weekly-reviews/       # Auto-generated summaries
├── work/                 # Work projects
├── projects/             # Personal projects
├── notes/                # Clippings, reading notes, reference
├── links/                # Link inbox (clear weekly)
├── personal/             # Personal context, important dates
├── dashboards/           # Task views, habit heatmaps
├── templates/            # Daily note, travel, weekly review
├── system/               # Config files
│   ├── meta-structure.md     (your schedule)
│   ├── recurring-tasks.md    (repeating tasks)
│   ├── active-habits.md      (what to track)
│   └── agent-spec.md         (the brain)
└── bot-inbox/            # Telegram message staging
```

All files use `lowercase-dashed` naming. Everything's editable in Obsidian: change your schedule, habits, or how the AI behaves by editing markdown.

---

## Docs

- [Setup Guide](docs/setup-guide.md): full walkthrough
- [Obsidian Setup](docs/obsidian-setup.md): plugin configuration
- [Agent Spec](docs/agent-spec.md): how the AI behaves
- [Cron Jobs](docs/cron-jobs.md): all automations explained
- [Cost Guide](docs/cost-guide.md): model routing, optimization
- [Gotchas](docs/gotchas.md): things that broke (and fixes)
- [Customization](docs/customization.md): adapt to your workflow

---

## What's Different

Most productivity tools are either templates you fill manually, or SaaS apps you don't own.

This is an AI agent that actually *operates* on your system. It reads your vault, manages your calendar, creates reminders, rolls over tasks, escalates blockers, and talks to you on Telegram. Anything you need to change can be done directly in Obsidian or via a message in Telegram. I prefer doing everything directly in Obsidian when I'm at my desk; it saves costs and I have more control. 

And you own every file. It's all markdown and git. No subscription to lose your data.

---

## Built With

- [OpenClaw](https://openclaw.ai): local AI agent framework
- [Obsidian](https://obsidian.md): knowledge base
- [Anthropic Claude](https://anthropic.com): Haiku / Sonnet / Opus
- Google Calendar · Apple Reminders · Telegram
- [Claude Code](https://claude.ai/code): built the entire system

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Issues and PRs welcome.

---

## Support

If this helps you, [buy me a coffee ☕](https://buymeacoffee.com/akshay93aditya)

---

## License

MIT — see [LICENSE](LICENSE).

---

*Built in a day by supervising Claude Code. Runs your life thereafter.*
