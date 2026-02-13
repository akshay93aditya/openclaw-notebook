# Privacy Checklist

Before sharing or pushing your fork publicly, review these files for personal information:

## ✅ Already Safe (Template Files)
- [x] `vault/system/agent-spec.md` - Uses `{{YOUR_NAME}}` placeholder
- [x] `vault/templates/daily-note.md` - Uses `{{TIMEZONE}}` placeholder
- [x] `vault/system/meta-structure.md` - Generic schedule template
- [x] `vault/system/recurring-tasks.md` - Example tasks only
- [x] `vault/system/active-habits.md` - Generic habit examples
- [x] `vault/personal/relationship/important-dates.md` - Format guide only (MM-DD placeholders)

## ⚠️ Review These Folders (Should Be Empty in Fresh Clone)
- [ ] `vault/daily-notes/` - Check for actual daily notes with personal content
- [ ] `vault/weekly-reviews/` - Check for actual weekly reviews
- [ ] `vault/bot-inbox/` - Check for captured Telegram messages
- [ ] `vault/projects/` - Check for real project files with names/details
- [ ] `vault/work/` - Check for work-related content
- [ ] `vault/notes/` - Check for personal notes, clippings, reading notes
- [ ] `vault/links/` - Check for saved links (might reveal interests/activity)
- [ ] `vault/personal/` - Check for any personal notes beyond the template

## 🔒 Never Commit These (Already in .gitignore)
- [x] `.env` - Contains API keys and tokens
- [x] `openclaw.json` - Contains API configuration
- [x] `.obsidian/workspace.json` - Personal workspace state
- [x] `.obsidian/workspace-mobile.json` - Mobile workspace state

## 🔍 Git History Check
- [ ] Run: `git log --all --pretty=format:"%an <%ae>"` to check commit author
  - Your name: Will appear (expected for public repos)
  - Email: Should be `noreply.github.com` or local machine email (not personal)

## 📝 Before Public Push
1. Verify all vault content folders are empty except templates
2. Confirm `.env` and `openclaw.json` are in `.gitignore`
3. Check git history for accidentally committed secrets
4. Review README for personal examples or references

## Quick Audit Commands

```bash
# Check for potentially personal content in vault
find vault/ -name "*.md" -type f ! -path "*/templates/*" ! -path "*/system/*" ! -name ".gitkeep"

# Verify sensitive files are ignored
git ls-files | grep -E "\.env|openclaw\.json"
# Should return nothing

# Check for placeholder replacement
grep -r "{{YOUR_NAME}}\|{{TIMEZONE}}" vault/ --include="*.md"
# Should show unreplaced placeholders

# Search for common personal data patterns
grep -ri "gmail\|@.*\.com\|phone\|address" vault/ --include="*.md"
```

## Status: ✅ CLEAN

Your current repository is **safe to share publicly**:
- All personal data files use placeholders
- Sensitive config files properly ignored
- No actual personal content in vault
- Git author uses local machine email (not revealing)
