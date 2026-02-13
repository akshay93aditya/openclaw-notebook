# Setup Guide

Complete walkthrough for setting up OpenClaw Notebook from scratch.

**Estimated time:** 3-4 hours
**Prerequisites:** macOS, Obsidian, Node.js ≥22, Homebrew

---

## Phase 1: Clone & Configure (15 min)

```bash
cd ~/Documents
git clone https://github.com/YOUR_USERNAME/openclaw-notebook.git
cd openclaw-notebook
chmod +x scripts/*.sh
./scripts/setup.sh
```

Fill in your name, timezone, and vault path. Then add API keys to `.env`.

## Phase 2: Obsidian (30 min)

1. Open `vault/` as an Obsidian vault
2. Install all 9 plugins (see [obsidian-setup.md](obsidian-setup.md))
3. Configure plugin settings
4. Test: create a daily note from template (Ctrl/Cmd + P → "Templater: Create new note from template")
5. Verify dashboards render (open `dashboards/task-dashboard.md`)

## Phase 3: Git Sync (20 min)

1. Create a **private** GitHub repo for your vault
2. Init git in `vault/` and push
3. Configure Obsidian Git plugin (5 min auto-sync)
4. Test: edit on one device → verify it appears on another

For iOS: install Working Copy, clone the repo, open in Obsidian.

## Phase 4: Calendar & Reminders (20 min)

```bash
./scripts/setup-calendar.sh   # Follow the guide
./scripts/setup-reminders.sh  # Follow the guide
```

Create the 4 Google Calendar sub-calendars and 4-6 Apple Reminders lists.

## Phase 5: OpenClaw (45 min)

```bash
# Install
curl -fsSL https://openclaw.ai/install.sh | bash
openclaw onboard --install-daemon

# Skills
npx clawhub install apple-reminders
npx clawhub install obsidian
brew install gog
gog auth  # Google Calendar OAuth
```

**Critical:** Put your API key in the `env` section of `openclaw.json`. See [gotchas.md](gotchas.md).

Point OpenClaw's workspace at your vault directory.

## Phase 6: Agent Onboarding (15 min)

Send the agent spec to your Telegram bot:
```bash
./scripts/onboard-agent.sh
```

Or copy-paste `vault/system/agent-spec.md` to your bot with the prefix "ONBOARDING SPEC".

Test with `/today` — you should get a briefing.

## Phase 7: Cron Jobs (15 min)

```bash
./scripts/setup-crons.sh
```

Verify: `openclaw cron list`

## Phase 8: Verification (15 min)

```bash
./scripts/health-check.sh
```

Then test manually:
- Send a task via Telegram (`/t Test task by 5pm`)
- Check it appears in your daily note
- Create a micro-task (`/t! Quick test`) → verify Apple Reminder fires
- Send `/today` → verify briefing arrives

---

## Customize

Edit these files to match your life:
- `vault/system/meta-structure.md` — your daily schedule
- `vault/system/recurring-tasks.md` — your recurring tasks
- `vault/system/active-habits.md` — your habits
- `vault/personal/relationship/important-dates.md` — your dates

See [customization.md](customization.md) for more.
