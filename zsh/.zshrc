################################################################################################
# RockingMonki aka My config for zsh
################################################################################################

# Install and setup zinit 
if [[ ! -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  mkdir -p "${HOME}/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.local/share/zinit/zinit.git" || true
fi
# Source zinit if it exists 
if [[ -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
fi

# Check if mise is installed and activate it
# Detect mise binary (use PATH if available, otherwise fallback to ~/.local/bin/mise)
if command -v mise >/dev/null 2>&1; then
  MISE_BIN=$(command -v mise)
else
  MISE_BIN="${HOME}/.local/bin/mise"
fi
# Run mise "activate" if the binary exists and is executable (keeps same behavior as before)
if [[ -x "$MISE_BIN" || -f "$MISE_BIN" ]]; then
  # ignore failures (we don't want shell startup to break)
  eval "$($MISE_BIN activate zsh 2>/dev/null)" 2>/dev/null || true
fi

###############################################################################################
# Initialise env and aliases
export EDITOR="nvim"

# zoxide as cd 
eval "$(zoxide init zsh --cmd cd)"
alias cat="bat"
alias cl="clear"
alias edit="$EDITOR ~/.zshrc"
alias ser="source ~/.zshrc"

# cd aliases 
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

# Git aliases 
alias gcb="git branch | fzf | cut -c 3- | xargs git checkout"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gsb="git status --short --branch"
alias gp="git push"
alias gc="git commit"

###################################################################################################
# History config 
HISTSIZE=20000
SAVEHIST=20000
setopt append_history

###################################################################################################
# zstyle and fzf & completion
eval "$(fzf --zsh)"

## zstyle
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
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
zstyle ':completion:*' completer _complete _ignored _approximate

# completion
autoload -Uz compinit
compinit -d 

##################################################################################################
#Plugins and snippets 
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

# setup vim bindkey
bindkey -v 
zinit ice wait lucid
zinit light jeffreytse/zsh-vi-mode

##################################################################################################
# zsh hooks and features setup

## ls on changing dirs
chpwd() {
  ls
}

# edit command widget 
autoload -Uz edit-command-line 
zle -N edit-command-line
bindkey '^e' edit-command-line

# Magic space 
bindkey " " magic-space

#################################################################################################
# other essential tools 
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"
###################################################################################################

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
