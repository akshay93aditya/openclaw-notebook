# Gotchas & Common Issues

Everything that broke during the original build — so it doesn't break for you.

---

## OpenClaw

**API key location**
Your Anthropic API key goes in the `env` section of `openclaw.json`, NOT in the auth profile.

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
`gog` is installed via Homebrew (`brew install gog`), not as an OpenClaw skill. It's a separate CLI that OpenClaw invokes.

**TUI rendering bug**
The OpenClaw TUI (terminal UI) has a known rendering bug in 2026.2.x versions. Use the Telegram interface as your primary interaction method.

**Compaction config values**
Valid values are: `safeguard`, `default`, `aggressive` — not "moderate" or "normal".

**Cron CLI syntax**
- Use `--message` not `--payload` for cron job prompts
- `--name` is a required flag
- Model overrides on crons require `--session isolated`
- `cron edit` is the command, not `cron update`
- `cron run` requires the full UUID, not the job name
- `--announce` replaces the old `--delivery` flag

**Root config files**
OpenClaw recreates `AGENTS.md`, `HEARTBEAT.md`, etc. at the vault root if you delete them. Don't fight it — hide them in Obsidian: Settings → Files & Links → Excluded Files → add `AGENTS.md`, `HEARTBEAT.md`, `CLAUDE.md`.

**Model config**
Don't use `openclaw config set` with quoted JSON keys containing `/` — it mangles them. Edit `openclaw.json` directly instead. And `openclaw models add` does NOT have an `--alias` flag.

**Rate limits**
Sonnet has a 30k input tokens/min limit. Heavy Telegram conversations + cron jobs running simultaneously can trigger 429 errors. The three-tier model routing helps prevent this.

**OAuth tokens**
Claude CLI's `setup-token` works interactively but may have issues with daemon processes. Use API key auth instead.

**Gateway auto-start**
`openclaw gateway install` creates the launchd plist so OpenClaw starts on boot. Verify with: `launchctl list | grep openclaw`

---

## Git Sync

**Conflict handling**
OpenClaw writes to HTML comment-delimited sections (`<!-- CALENDAR_START -->`, etc.). You write everywhere else. Conflicts are rare. If one occurs, OpenClaw auto-resolves by keeping both versions.

**Sync lag**
Git sync runs every 5 minutes. If you edit on your phone and immediately open on Mac, there may be a lag. Pull manually if needed.

**Working Copy (iOS)**
Set fetch interval to 15 min (iOS background app limit). For faster sync, open Working Copy and pull manually.

---

## Obsidian

**Plugin load order**
After installing all plugins, restart Obsidian once. Some plugins (Dataview, Templater) need a restart to initialize.

**Dataview queries returning empty**
Dataview needs to index the vault first. Wait ~30 seconds after opening Obsidian, then refresh the dashboard page.

**Templater not rendering**
If Templater shows raw `<% tp.date... %>` instead of dates, check that Templater is enabled and the template folder is set to `templates` in Templater settings.

---

## Apple Reminders

**Location triggers**
Location geofences must be set up on the iPhone directly. The Mac CLI creates the reminder, but the geofence trigger needs iOS configuration.

**Shared lists**
Both people need to accept the sharing invitation for the shared list to sync.

---

## Cost Surprises

**Claude Max doesn't cover OpenClaw**
As of early 2026, Anthropic blocks third-party tools from using Claude Max subscription auth. All OpenClaw costs are pure API pay-per-use.

**Heartbeat costs**
Default is every 2 hours with 2 checks. Don't set it lower than that unless you have a reason — the original 30-min interval was the #2 cost driver before optimization.

**Setup day costs**
Expect ~$20 for the setup day due to heavy back-and-forth during onboarding. Not representative of daily running costs.

---

## Security Checklist

Before going live, verify:

```bash
# Run OpenClaw's security audit
openclaw security audit --deep --fix

# Lock down config files
chmod 600 ~/.openclaw/openclaw.json
chmod 700 ~/.openclaw/credentials/

# Verify gateway is localhost-only
netstat -an | grep 18789 | grep LISTEN

# Check no API keys leaked into vault
grep -r "sk-ant" ~/path/to/vault/

# Verify git repo is private (for your personal vault)
```
