# Task Dashboard

#### 🔴 Due Today
```dataview
TASK FROM "" WHERE !completed AND due = date(today) SORT priority DESC
```

#### 🟡 Due This Week
```dataview
TASK FROM "" WHERE !completed AND due > date(today) AND due <= date(today) + dur(7 days) SORT due ASC
```

#### 🔵 Escalated (3+ Days Overdue)
```dataview
TASK FROM "" WHERE !completed AND due AND due <= date(today) - dur(3 days) SORT due ASC
```

#### 🔖 Waiting On Others
```dataview
TASK FROM "" WHERE !completed AND contains(text, "🔖waiting") SORT due ASC
```

#### 💰 Financial Deadlines
```dataview
TASK FROM "" WHERE !completed AND contains(text, "💰") SORT due ASC
```

#### 🟢 Unscheduled
```dataview
TASK FROM "" WHERE !completed AND !due SORT file.ctime DESC LIMIT 20
```
