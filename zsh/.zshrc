################################################################################################
# RockingMonki aka My config for zsh
################################################################################################

# Prompt 
setopt PROMPT_SUBST
autoload -U colors && colors

################################################################################################
# Git prompt (FIXED: no recursion, cached)

GIT_PROMPT_INFO=""

update_git_prompt() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
        GIT_PROMPT_INFO=""
        return
    }

    local branch git_state=""

    # Branch (supports detached HEAD)
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || \
    branch=$(git rev-parse --short HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        GIT_PROMPT_INFO=" %{$fg[magenta]%}⎇%{$reset_color%} %{$fg[yellow]%}${branch}%{$reset_color%}"
    fi

    # Fast status checks
    git diff --quiet 2>/dev/null || git_state+="%{$fg[red]%}!%{$reset_color%}"
    git diff --cached --quiet 2>/dev/null || git_state+="%{$fg[yellow]%}+%{$reset_color%}"

    if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        git_state+="%{$fg[blue]%}?%{$reset_color%}"
    fi

    [ -z "$git_state" ] && git_state="%{$fg[green]%}✓%{$reset_color%}"

    GIT_PROMPT_INFO+=" ${git_state}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd update_git_prompt

################################################################################################
# User color
user_color() {
    if [ $UID -eq 0 ]; then
        echo "%{$fg[red]%}"
    else
        echo "%{$fg[green]%}"
    fi
}

# Exit code arrow
exit_code() {
    echo "%(?.%{$fg[green]%}.%{$fg[red]%})➜%{$reset_color%}"
}

# PROMPT (UNCHANGED LAYOUT)
PROMPT='%{$fg[cyan]%}%~%{$reset_color%}${GIT_PROMPT_INFO} %(?.%{$fg[green]%}.%{$fg[red]%})➜%{$reset_color%} : '
################################################################################################
# Install and setup zinit 
if [[ ! -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  mkdir -p "${HOME}/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.local/share/zinit/zinit.git" || true
fi

if [[ -f "${HOME}/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
fi

################################################################################################
# Mise
if command -v mise >/dev/null 2>&1; then
  MISE_BIN=$(command -v mise)
else
  MISE_BIN="${HOME}/.local/bin/mise"
fi

if [[ -x "$MISE_BIN" || -f "$MISE_BIN" ]]; then
  eval "$($MISE_BIN activate zsh 2>/dev/null)" 2>/dev/null || true
fi

################################################################################################
# Env + aliases
export EDITOR="nvim"

eval "$(zoxide init zsh --cmd cd)"
alias cat="bat"
alias cl="clear"
alias edit="$EDITOR ~/.zshrc"
alias ser="source ~/.zshrc"

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

################################################################################################
# History
HISTSIZE=20000
SAVEHIST=20000
setopt append_history

################################################################################################
# fzf + completion
eval "$(fzf --zsh)"

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

autoload -Uz compinit
compinit -d

################################################################################################
# Plugins

# Load autosuggestions LAST to avoid recursion issues
zinit snippet OMZP::eza
zinit snippet OMZP::uv
zinit snippet OMZP::rust

zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

bindkey -v 

zinit ice wait lucid
zinit light jeffreytse/zsh-vi-mode

# AUTOSUGGESTIONS LAST (important fix)
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

################################################################################################
# Hooks

chpwd() {
  ls
}

autoload -Uz edit-command-line 
zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey " " magic-space

################################################################################################
# Tools
eval "$(atuin init zsh)"

################################################################################################
# Go
export GOPATH="$HOME/go"
export GOROOT="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
