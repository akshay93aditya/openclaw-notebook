# Gotchas & Common Issues

Things that broke during the original build — so they don't break for you.

---

## OpenClaw

**API key location**
Your Anthropic API key goes in the `env` section of `openclaw.json`, NOT in the auth profile. If the agent can't respond, this is probably why.

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "sk-ant-..."
  }
}
```

**Skill installation**
Use `npx clawhub install <skill-name>`, not `npm install`. These are OpenClaw skills, not npm packages.

**Google Calendar (gog)**
`gog` is installed via Homebrew (`brew install gog`), not as an OpenClaw skill. It's a separate CLI tool that OpenClaw uses.

**TUI rendering bug**
The OpenClaw TUI (terminal UI) has a known rendering bug in 2026.2.x versions. Use the Telegram interface as your primary interaction method.

**Config values**
Compaction modes are: `safeguard`, `default`, `aggressive` — not "moderate" or "normal".

**Cron syntax**
Use `--message` not `--payload` for cron job prompts. `--name` is a required flag.

**Root config files**
OpenClaw recreates `AGENTS.md`, `HEARTBEAT.md`, etc. at the vault root if you delete them. Hide them in Obsidian: Settings → Files & Links → Excluded Files → add `AGENTS.md`, `HEARTBEAT.md`, `CLAUDE.md`.

**Rate limits**
Opus has a 30k input tokens/min limit. Heavy conversations + cron jobs running simultaneously can trigger 429 errors. The 3-tier model routing helps prevent this.

---

## Git Sync

**Conflict handling**
OpenClaw writes to HTML comment sections (`<!-- CALENDAR_START -->`, etc.). You write everywhere else. If a conflict occurs, OpenClaw auto-resolves by keeping both versions.

**Sync lag**
Git sync runs every 5 minutes. If you edit on your phone and immediately open on Mac, there may be a lag. Pull manually if needed (`git pull` in vault directory).

**Working Copy (iOS)**
Set fetch interval to 15 min (iOS background app limit). For faster sync, open Working Copy and pull manually.

---

## Obsidian

**Plugin load order**
After installing all plugins, restart Obsidian once. Some plugins (Dataview, Templater) need a restart to initialize properly.

**Dataview queries returning empty**
Dataview needs to index the vault first. Wait ~30 seconds after opening Obsidian, then refresh the dashboard page.

**Templater date formatting**
If Templater shows raw `<% tp.date... %>` instead of dates, check that Templater is enabled and the template folder is set correctly in Templater settings.

---

## Apple Reminders

**Location triggers**
Location geofences must be set up on the iPhone directly. You can't create location-based reminders from Mac CLI alone — the reminder gets created, but the geofence trigger needs to be configured on iOS.

**Shared lists**
Both people need to accept the sharing invitation for the shared list to sync properly.

---

## Cost Surprises

**Claude Max doesn't cover OpenClaw**
As of early 2026, Anthropic blocks third-party tools from using Claude Max subscription auth. All OpenClaw costs are pure API pay-per-use via console.anthropic.com.

**Heartbeat costs**
If you set heartbeat interval too low (e.g. every 5 minutes), costs add up fast. Default is every 2 hours with only 2 checks (calendar + reminders sync).

**Long conversations**
Extended back-and-forth on Telegram with Sonnet can cost $1-2.50/day. Keep messages concise for cheaper operation.
