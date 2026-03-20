# zinit (install if missing)
if [[ ! -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  mkdir -p "${HOME}/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.local/share/zinit/zinit.git" || true
fi

# Source zinit (safe even if clone failed)
if [[ -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
fi

# Paths and variables
export EDITOR="nvim"
# Detect mise binary (use PATH if available, otherwise fallback to ~/.local/bin/mise)
if command -v mise >/dev/null 2>&1; then
  MISE_BIN=$(command -v mise)
else
  MISE_BIN="${HOME}/.local/bin/mise"
fi

# Run mise "activate" if the binary exists and is executable (keeps same behavior as before)
if [[ -x "$MISE_BIN" || -f "$MISE_BIN" ]]; then
  # mise activate prints shell code; evaluate it in a safe manner
  # ignore failures (we don't want shell startup to break)
  eval "$($MISE_BIN activate zsh 2>/dev/null)" 2>/dev/null || true
fi

# Completion system (must run AFTER fpath and after generating completions)
autoload -Uz compinit
# Use a stable cache file for compinit
compinit -d 
# zstyle tweaks for fzf-tab / previews and general completion behavior
zstyle ':completion:*:cd:*' fzf-preview 'eza --tree --level=2 --color=always --icons $realpath'
zstyle ':completion:*' fzf-preview '
  if [ -d $realpath ]; then
    eza --tree --level=2 --color=always --icons $realpath
  else
    bat --style=numbers --color=always --line-range=:300 $realpath 2>/dev/null
  fi
'
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# keep list-colors from the environment if set
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
eval "$(fzf --zsh)"

# Prompt 
eval "$(starship init zsh)"

alias cat="bat"
alias cl="clear"
alias edit="$EDITOR ~/.zshrc"
alias ser="source ~/.zshrc"
alias al="alias | fzf"
alias gcb="git branch | fzf | cut -c 3- | xargs git checkout"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gsb="git status --short --branch"
alias gp="git push"
alias gc="git commit"

# vi keybinding
bindkey -v

# zoxide & atuin if available
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# edit command widget 
autoload -Uz edit-command-line 
zle -N edit-command-line
bindkey '^e' edit-command-line

# Magic space 
bindkey " " magic-space


# Useful OMZP snippets (kept minimal and stable)
# Prefer the OMZP snippets for common features — safe, no heavy changes.
zinit snippet OMZP::eza
zinit snippet OMZP::uv
zinit snippet OMZP::rust

# fzf shell helpers (key-bindings + completion) — keep these as raw snippets
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh

# Plugins
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light jeffreytse/zsh-vi-mode

# Safety & small performance tweaks
# Reduce history file writes frequency (optional, safe)
HISTSIZE=20000
SAVEHIST=20000
setopt append_history

# Faster prompt redraw (avoid slow startup IO)
zstyle ':completion:*' completer _complete _ignored _approximate

chpwd() {
  ls
}

# bun completions
[ -s "/home/monki/.bun/_bun" ] && source "/home/monki/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
