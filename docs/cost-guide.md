# Cost Guide

## Model Routing (Built-In Optimization)

The system uses three tiers to keep costs down:

| Tier | Model | Cost (per 1M tokens in/out) | Used For |
|------|-------|----------------------------|----------|
| Dumb | Haiku 4.5 | $1 / $5 | Heartbeats, simple crons, file operations |
| Default | Sonnet 4.5 | $3 / $15 | Telegram interactions, critical crons, task routing |
| Smart | Opus 4.5 | $15 / $75 | On-demand only — agent asks before using |

## Setup Cost

Expect ~$20 for the initial setup day. This involves heavy back-and-forth with Sonnet/Opus during onboarding and testing. Not representative of daily costs.

## Monthly Projections

| Usage Level | Monthly Cost |
|-------------|-------------|
| Light (10 msgs/day, few crons) | ~$10 |
| Normal (15-20 msgs/day, all crons) | ~$15-20 |
| Heavy (30+ msgs, Opus usage) | ~$30+ |

*These are early estimates — still being optimized.*

## Cost Reduction Tips

1. **Keep Telegram messages concise.** Each message = Sonnet parse + Haiku execution.
2. **Use slash commands** over plain text — faster parsing, fewer tokens.
3. **Don't manually trigger Opus.** Let Sonnet handle it. Opus is 5x the cost.
4. **Reduce heartbeat frequency** if you don't need real-time calendar monitoring.
5. **Batch similar tasks** into single messages instead of sending them one by one.

## Monitoring

Check your usage at [console.anthropic.com](https://console.anthropic.com) → Usage tab.

Set a monthly budget alert to avoid surprises.
