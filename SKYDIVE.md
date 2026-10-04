# mp-skills-skydive — adaptation notes

Fork of [mattpocock/skills](https://github.com/mattpocock/skills) for the Skydive platform (DesignSpark Studio). Changes from upstream:

1. **Skill tool refs:** skills that say "Call the Skill tool with X" now carry a Skydive adaptation note: read the referenced SKILL.md directly (no cross-skill invocation in this harness).
2. **Subagents:** implement-spec/wayfinder worker conventions map to the Skydive `subagent` tool; no shared scratch filesystem — coordination via inline results and platform conversation steering.
3. **tdd renamed to tdd-pocock** to avoid colliding with pstack's `tdd`. Rule of thumb: pstack's tdd during poteto-mode/bug fixes; tdd-pocock for feature work and integration tests.
4. **Repo config:** setup-matt-pocock-skills maps to Notion MoveTogether Engineering DB (tracker) + team bug-flow labels + GLOSSARY.md/ADRs in each project repo root.
5. **Skipped buckets:** misc, deprecated, in-progress are not installed.

## Roles
- **eng** (Hermione, Romeo, Matt, Paige): full engineering pipeline (spec → tickets → implement, code-review, diagnosing-bugs, domain-modeling, triage, retro, prototype, research).
- **research** (Vera): research, grill-me, writing-for-agents, triage, to-questionnaire.
- **content** (Flute, Bun, Marco, Ren, Babs, Maverick, Herald): writing-for-agents, handoff.
- **Vigil:** eng minus the pipeline (code-review, diagnosing-bugs) — use the eng role; overlap is harmless.

## Install (each agent runs in its own sandbox)
```
bash <(curl -fsSL https://raw.githubusercontent.com/samuelpullen15-droid/mp-skills-skydive/main/install-skydive.sh) <eng|research|content>
```
