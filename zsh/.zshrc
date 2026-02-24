# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

# Source zcomet.zsh
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# mise setup
eval "$(~/.local/bin/mise activate zsh)"

# Prompt
# PROMPT="%F{magenta}%~%f %B%F{green}~>%f%b "
eval "$(starship init zsh)"

# Aliases
export EDITOR="nvim"

alias cat="bat"
alias cl="clear"
alias edit="$EDITOR ~/.zshrc"
alias ser="source ~/.zshrc"

# Keybinding 
bindkey -v

# Tooling setup
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"

# completion setup 

autoload -Uz compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

fpath=(~/.zsh/completions $fpath)

compinit -d ~/.zsh/cache/zcompdump

# Use fzf-tab for cd
zstyle ':completion:*:cd:*' fzf-preview 'eza --tree --level=2 --color=always --icons $realpath'

# Preview directories when completing any path
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

# Plugins

## snippets
zcomet snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/eza/eza.plugin.zsh
zcomet snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
zcomet snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zcomet snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

## loads
zcomet load zsh-users/zsh-autosuggestions
zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load Aloxaf/fzf-tab
zcomet load jeffreytse/zsh-vi-mode
