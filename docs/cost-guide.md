# Cost Guide

## Model Routing (Built-In Optimization)

The system uses three tiers to keep costs down:

| Tier | Model | Cost (per 1M tokens in/out) | Used For |
|------|-------|----------------------------|----------|
| Dumb | Haiku 4.5 | $1 / $5 | Heartbeats, simple crons, file operations |
| Default | Sonnet 4.5 | $3 / $15 | Telegram interactions, critical crons, task routing |
| Smart | Opus 4.5 | $15 / $75 | On-demand only — agent asks before using |

## Daily Cost Breakdown

| Component | Estimated Daily Cost |
|-----------|---------------------|
| Heartbeat (12x/day, Haiku) | ~$0.05 |
| Cron jobs (6 daily, Haiku/Sonnet mix) | ~$0.15-0.20 |
| Telegram interactions (15-25 msgs, Sonnet) | ~$1.00-2.50 |
| Weekly crons (amortized daily) | ~$0.03 |
| **Total** | **~$1.30-2.80/day** |

## Monthly Projections

| Usage Level | Monthly Cost |
|-------------|-------------|
| Light (10 msgs/day, few crons) | ~$40 |
| Normal (20 msgs/day, all crons) | ~$60-80 |
| Heavy (30+ msgs, Opus usage) | ~$85+ |

## Cost Reduction Tips

1. **Keep Telegram messages concise.** Each message = Sonnet parse + Haiku execution.
2. **Use slash commands** over plain text — faster parsing, fewer tokens.
3. **Don't manually trigger Opus.** Let Sonnet handle it. Opus is 5x the cost.
4. **Reduce heartbeat frequency** if you don't need real-time calendar monitoring.
5. **Batch similar tasks** into single messages instead of sending them one by one.

## Monitoring

Check your usage at [console.anthropic.com](https://console.anthropic.com) → Usage tab.

Set a monthly budget alert to avoid surprises.
