# New Computer Setup

## Quick Start

```bash
git clone <this-repo> ~/dev/setup
cd ~/dev/setup
bash bootstrap.sh
```

The bootstrap script runs each step in order and prints a summary of what succeeded or failed. If a step fails, you can re-run it individually:

```bash
bash scripts/03-oh-my-zsh.sh
```

## What Gets Installed

| Step | Script              | What it does                                              |
| ---- | ------------------- | --------------------------------------------------------- |
| 1    | `01-homebrew.sh`    | Installs Homebrew (or updates it)                         |
| 2    | `02-packages.sh`    | Installs everything in `Brewfile`                         |
| 3    | `03-oh-my-zsh.sh`   | Installs Oh My Zsh + Shades of Purple theme               |
| 4    | `04-node.sh`        | Installs Node.js LTS via fnm                              |
| 5    | `05-ruby.sh`        | Installs Ruby via rbenv                                   |
| 6    | `06-symlinks.sh`    | Symlinks dotfiles into `$HOME`                            |
| 7    | `07-ssh.sh`         | Generates SSH key, configures Keychain, prints public key |
| 8    | `08-macos.sh`       | Applies macOS system defaults                             |
| 9    | `09-npm-globals.sh` | Installs global npm packages (incl. cclsp)                |
| 10   | `10-ruby-gems.sh`   | Installs global Ruby gems                                 |
| 11   | `11-claude-mcp.sh`  | Registers MCP servers with Claude Code                    |

## Manual Steps

- **iTerm2 color scheme** — after bootstrap, double-click `~/tmp/shades-of-purple.itermcolors` and import in iTerm2 > Preferences > Profiles > Colors > Color Presets

## Dotfiles

| File                  | Symlinked to                  |
| --------------------- | ----------------------------- |
| `dotfiles/.zshrc`     | `~/.zshrc`                    |
| `dotfiles/.vimrc`     | `~/.vimrc`                    |
| `dotfiles/.gitconfig` | `~/.gitconfig`                |
| `dotfiles/AGENTS.md`  | `~/.claude/CLAUDE.md`         |
| `dotfiles/cclsp.json` | `~/.config/claude/cclsp.json` |

## Adding Packages

Edit `Brewfile` and run:

```bash
brew bundle --file=Brewfile
```
