# =============================================================================
# Oh My Zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="shades-of-purple"
plugins=(git)
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

alias sz='source ~/.zshrc'
alias zc='${EDITOR} ~/.zshrc'

# =============================================================================
# fnm — Fast Node Manager
# =============================================================================
eval "$(fnm env --use-on-cd)"

# =============================================================================
# rbenv — Ruby version manager
# =============================================================================
eval "$(rbenv init - zsh)"

# =============================================================================
# Shell plugins (installed via Homebrew)
# =============================================================================
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# direnv hook
eval "$(direnv hook zsh)"

# =============================================================================
# Claude Code
# =============================================================================

export ENABLE_LSP_TOOL=1

# =============================================================================
# git
# =============================================================================
alias gs='git status'
alias gap='git add -p'
alias gaa='git add .'
alias glog='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcm='git commit -m'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias gpp='git pull --prune'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(git rev-parse --abrev-ref HEAD)'
