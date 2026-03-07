# AGENTS instructions

## Process

- If there's uncertainty, prefer to ask over making assumptions
- Every time a decision is made (either by an agent or a human), follow [the decision guide](./guides/decisions.md)

## Boundaries

- **Ask first**
  - Large cross-package refactors.
  - New dependencies with broad impact.
  - Destructive data or migration changes.

- **Never**
  - Commit secrets, credentials, or tokens.
  - Edit generated files by hand when a generation workflow exists.
  - Use destructive git operations unless explicitly requested.
