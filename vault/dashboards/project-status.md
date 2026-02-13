# Project Status

```dataview
TABLE WITHOUT ID
  file.link AS "Project",
  status AS "Status",
  file.mtime AS "Last Updated"
FROM "projects" OR "work"
WHERE contains(file.name, "_index")
SORT file.mtime DESC
```
