---
name: claude-handoff
description: Hand the current conversation off to a fresh background agent that picks up the work immediately.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff summary of the current conversation so a fresh agent can continue the work. Instead of saving it, launch a background agent seeded with the summary as its prompt: `claude --bg --name "<descriptive name>" "<handoff summary>"`. It starts in the current working directory and returns immediately; the user manages it with `claude agents`.

Always pass `-n`/`--name` with a descriptive name (e.g. `--name "Fix login bug"`); it sets the display name shown in the job list, session picker, and terminal title.

Include a "suggested skills" section in the summary, naming which skills the next agent should call the Skill tool for.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information, since the summary becomes the agent's prompt.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the summary accordingly.


---

## Skydive adaptation (DesignSpark Studio fork)

In this Skydive environment:
- There is no cross-skill "Skill tool". When this skill says "Call the Skill tool with X", instead READ the referenced skill's `SKILL.md` directly (e.g. `~/.pi/agent/skills/X/SKILL.md`) and apply it.
- Subagents spawn with the Skydive `subagent` tool: `subagent({ tasks: [{ task, title, persona?, model?, timeoutMinutes? }] })`. Run implementers in background (default) for concurrency; each runs in its own sandbox. Shared scratch notes: each worker commits notes to its own sandbox and returns key findings inline in its result, OR you pre-clone the repo into a known path and pass the path in the brief. There is no shared filesystem across workers.
- Steering a running subagent: `platform conversations post <id> --message "..."`; inspect: `platform conversations show <id>`.
- The repo-config skill (setup-matt-pocock-skills) maps to: issue tracker = the team's Notion MoveTogether Engineering database; triage labels per the team's bug-flow SOP; GLOSSARY.md/ADRs live in the repo root of the project being worked.
