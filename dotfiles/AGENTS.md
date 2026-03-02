# AGENTS instructions

## Boundaries

- **Ask first**
  - Large cross-package refactors.
  - New dependencies with broad impact.
  - Destructive data or migration changes.

- **Never**
  - Commit secrets, credentials, or tokens.
  - Edit generated files by hand when a generation workflow exists.
  - Use destructive git operations unless explicitly requested.
