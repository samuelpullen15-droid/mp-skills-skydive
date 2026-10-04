---
name: tdd-pocock
description: "Test-driven development (Pocock variant). Use for feature work and integration tests. For bug-fix-shaped work while running poteto-mode, prefer pstack's `tdd` skill." Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
---

# Test-Driven Development

TDD is the red → green loop. This skill is the reference that makes that loop produce tests worth keeping: what a good test is, where tests go, the anti-patterns, and the rules of the loop. Every section applies on every cycle: consult them before and during the loop, not after.

When exploring the codebase, read `GLOSSARY.md` (if it exists) so test names and interface vocabulary match the project's domain language, and respect ADRs in the area you're touching.

## What a good test is

Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't. A good test reads like a specification: "user can checkout with valid cart" tells you exactly what capability exists, and it survives refactors because it doesn't care about internal structure.

See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

## Seams: where tests go

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals.

**Test only at pre-agreed seams.** Before writing any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam. You can't test everything, so agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

Ask: "What's the public interface, and which seams should we test?"

When the shape of that interface is itself in question (how deep the module is, where the seam belongs, what the interface should expose), call the Skill tool with "codebase-design" for the vocabulary. It is the shared source of the module, interface, depth, seam, adapter, leverage and locality terms, and it is a reference to consult, not a session to run.

## Anti-patterns

- **Implementation-coupled**: mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
- **Tautological**: the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth: a known-good literal, a worked example, the spec.
- **Horizontal slicing**: writing all tests first, then all implementation. Bulk tests verify _imagined_ behavior: you test the _shape_ of things rather than user-facing behavior, the tests go insensitive to real changes, and you commit to test structure before understanding the implementation. Work in **vertical slices** instead: one test → one implementation → repeat, each test a **tracer bullet** that responds to what the last cycle taught you.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Don't anticipate future tests or add speculative features.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring is not part of the loop.** It belongs to the review stage (see the `code-review` skill), not the red → green implementation cycle.


---

## Skydive adaptation (DesignSpark Studio fork)

In this Skydive environment:
- There is no cross-skill "Skill tool". When this skill says "Call the Skill tool with X", instead READ the referenced skill's `SKILL.md` directly (e.g. `~/.pi/agent/skills/X/SKILL.md`) and apply it.
- Subagents spawn with the Skydive `subagent` tool: `subagent({ tasks: [{ task, title, persona?, model?, timeoutMinutes? }] })`. Run implementers in background (default) for concurrency; each runs in its own sandbox. Shared scratch notes: each worker commits notes to its own sandbox and returns key findings inline in its result, OR you pre-clone the repo into a known path and pass the path in the brief. There is no shared filesystem across workers.
- Steering a running subagent: `platform conversations post <id> --message "..."`; inspect: `platform conversations show <id>`.
- The repo-config skill (setup-matt-pocock-skills) maps to: issue tracker = the team's Notion MoveTogether Engineering database; triage labels per the team's bug-flow SOP; GLOSSARY.md/ADRs live in the repo root of the project being worked.
