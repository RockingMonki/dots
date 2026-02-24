# Install zinit automatically if not present
if [[ ! -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  mkdir -p "${HOME}/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.local/share/zinit/zinit.git"
fi

# Activate zinit
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"

# mise setup (keeps same behaviour)
eval "$(~/.local/bin/mise activate zsh)"

# Prompt
eval "$(starship init zsh)"

# Aliases
export EDITOR="nvim"
alias cat="bat"
author=""
alias cl="clear"
alias edit="$EDITOR ~/.zshrc"
alias ser="source ~/.zshrc"
alias al="alias | fzf"

# Keybinding
bindkey -v

# Tooling setup
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"

# Oh-My-Zsh plugins via OMZP (cleaner than raw snippets)
zinit snippet OMZP::eza
zinit snippet OMZP::git
zinit snippet OMZP::uv

# fzf shell helpers (key-bindings + completion)
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh

# Completion setup (cache + fpath)
autoload -Uz compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
fpath=(~/.zsh/completions $fpath)
compinit -d ~/.zsh/cache/zcompdump

# zstyle tweaks for fzf-tab / previews
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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# --- Plugins loaded with zinit turbo (delayed until prompt) ---
# Use `wait` ice to enable turbo-mode (loads after the first prompt is displayed)

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light jeffreytse/zsh-vi-mode

