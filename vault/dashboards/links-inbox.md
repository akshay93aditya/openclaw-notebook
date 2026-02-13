# 🔗 Links Inbox

```dataview
TABLE WITHOUT ID
  file.link AS "Link",
  file.ctime AS "Added",
  choice(date(today) - file.ctime > dur(7 days), "⚠️ OVERDUE", "📋 This Week") AS "Status"
FROM "links/inbox"
SORT file.ctime ASC
```
