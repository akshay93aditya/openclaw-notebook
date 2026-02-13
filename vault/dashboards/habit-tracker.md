# Habit Tracker

#### This Week
```dataview
TABLE WITHOUT ID
  file.link AS "Day",
  choice(contains(file.tasks.text, "#habit/exercise"), choice(contains(file.tasks.status, "x"), "✅", "❌"), "—") AS "🏋️",
  choice(contains(file.tasks.text, "#habit/reading"), choice(contains(file.tasks.status, "x"), "✅", "❌"), "—") AS "📖",
  choice(contains(file.tasks.text, "#habit/writing"), choice(contains(file.tasks.status, "x"), "✅", "❌"), "—") AS "✍️"
FROM "daily-notes"
WHERE date >= date(today) - dur(6 days)
SORT date ASC
```

> Customize the habit columns to match your `system/active-habits.md`.
> Configure Heatmap Calendar plugin for long-term visualization.
