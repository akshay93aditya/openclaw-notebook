# Customization Guide

Everything in OpenClaw Notebook is designed to be modified. Here's what to change and where.

---

## Your Schedule

**File:** `vault/system/meta-structure.md`

Replace the default time blocks with your actual schedule. This is what OpenClaw reads when planning your week and scheduling tasks.

Common adjustments:
- Night owl? Shift all blocks later
- Part-time? Remove evening work block
- No meetings? Remove meeting-specific blocks
- Variable schedule? Define multiple patterns and note which days use which

## Your Habits

**File:** `vault/system/active-habits.md`

Add or remove habits. Keep the `#habit/tag` format for Dataview tracking.

Then update `vault/dashboards/habit-tracker.md` to match — add/remove columns in the Dataview table.

## Your Tasks

**File:** `vault/system/recurring-tasks.md`

Define anything that repeats: daily, weekly, monthly, quarterly, annual. OpenClaw creates these automatically on schedule.

## Important Dates

**File:** `vault/personal/relationship/important-dates.md`

Birthdays, anniversaries, visa renewals, lease dates. OpenClaw creates prep tasks at -14 and -7 days automatically.

## Daily Note Template

**File:** `vault/templates/daily-note.md`

Add or remove sections to match your workflow. Keep the `####` header format and `---` dividers for consistency.

Ideas for custom sections:
- Gratitude log
- Learning log
- Health tracking
- Financial tracking

## Agent Personality

**File:** `vault/system/agent-spec.md`

Modify the personality section to change how OpenClaw communicates. Make it more formal, more casual, more terse — whatever works.

## Cron Job Timing

Re-run `./scripts/setup-crons.sh` after editing the schedule in the script. Or modify individual crons with `openclaw cron update`.

## Adding Projects

Create a folder in `vault/work/` or `vault/projects/`, add a `_index.md` using the project template, and OpenClaw will start tracking it.

## Removing Features

Don't want the shared/relationship layer? Delete `vault/personal/relationship/` and remove the personal-dates cron.

Don't want link tracking? Remove the Links sections from the daily note template and delete the link-related crons.

Everything is modular — remove what you don't need.
