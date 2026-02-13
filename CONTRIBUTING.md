# Contributing to OpenClaw Notebook

Thanks for your interest! Here's how to contribute.

## Ways to Contribute

- **Bug reports** — something broken? Open an issue with steps to reproduce
- **Feature requests** — ideas for new automations, templates, or workflows
- **Documentation** — improvements to setup guides, gotchas, or explanations
- **Templates** — new daily note templates, dashboard views, or system files
- **Scripts** — setup automation, health checks, or migration tools
- **Cron jobs** — useful scheduled automations others might want

## Guidelines

1. **Keep it local-first.** No suggestions that require cloud services beyond what's already used (Anthropic API, Google Calendar, Telegram).
2. **Keep it markdown.** Everything in the vault should be plain markdown. No proprietary formats.
3. **Keep it configurable.** New features should use placeholders (`{{VARIABLE}}`) that the setup script can replace.
4. **Test on macOS.** The system is built for macOS + Apple ecosystem. Linux support is welcome but shouldn't break macOS.

## Submitting Changes

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Test with a fresh vault if possible
5. Submit a PR with a clear description of what and why

## Reporting Issues

Use the issue templates. Include:
- Your macOS version
- OpenClaw version (`openclaw --version`)
- Node.js version (`node --version`)
- What you expected vs what happened
- Relevant logs

## Code of Conduct

Be kind. Be helpful. We're all just trying to get our lives together.
