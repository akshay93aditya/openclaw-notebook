# Obsidian Setup

## Required Plugins

Install these from Obsidian → Settings → Community Plugins → Browse:

| Plugin | Purpose | Key Settings |
|--------|---------|-------------|
| **Templater** | Dynamic daily note generation | Template folder: `templates` |
| **Periodic Notes** | Auto-create daily/weekly notes | Daily folder: `daily-notes`, Weekly folder: `weekly-reviews` |
| **Tasks** | Due dates, recurrence, priority | Global filter: empty, Done date: ON, Recurrence: ON |
| **Dataview** | Dashboards and queries | Enable JavaScript queries for heatmaps |
| **Obsidian Git** | Sync via GitHub | Auto pull/push: 5 min, Pull on startup: ON |
| **Calendar** | Sidebar calendar UI | Default |
| **Heatmap Calendar** | Habit visualization | Configure with DataviewJS |
| **Rollover Daily Todos** | Carry undone tasks | Delete original: OFF, Roll children: ON |
| **Reminder** | In-app notifications | Default |

## Plugin Configuration

### Obsidian Git
```
Auto pull interval: 5 minutes
Auto push interval: 5 minutes
Pull on startup: ON
Commit message: "vault backup: {{date}}"
```

### Periodic Notes
```
Daily note folder: daily-notes
Daily note template: templates/daily-note
Weekly note folder: weekly-reviews
Weekly note template: templates/weekly-review
```

### Rollover Daily Todos
```
Delete original tasks: OFF (preserves history)
Roll over children: ON
```

## Excluded Files

Hide OpenClaw's auto-generated root files:
Settings → Files & Links → Excluded Files → add:
- `AGENTS.md`
- `HEARTBEAT.md`
- `CLAUDE.md`
- `.openclaw/`

## Git Setup

### Mac
```bash
cd /path/to/vault
git init
git remote add origin git@github.com:YOUR_USERNAME/your-vault-repo.git
git push -u origin main
```

### iOS (iPhone / iPad)
1. Install Working Copy ($20 one-time)
2. Clone your vault repo in Working Copy
3. Open vault in Obsidian iOS from Working Copy directory
4. Set fetch interval to 15 min
