# PROMPT
# -----------------------------
# Minimal Two-Line Prompt Setup
# -----------------------------

# Enable prompt substitution
setopt PROMPT_SUBST

# Load colors
autoload -U colors && colors
autoload -Uz add-zsh-hook
add-zsh-hook precmd add_blank_line

add_blank_line() { print "" }

# Git status function
git_prompt_info() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch git_state
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match)

    git_state=$(git status --porcelain=2 --branch 2>/dev/null)

    local ahead behind staged changed untracked
    ahead=$(echo "$git_state" | awk '/branch.ab/ {print $3}' | sed 's/+//')
    behind=$(echo "$git_state" | awk '/branch.ab/ {print $4}' | sed 's/-//')

    staged=$(echo "$git_state" | grep -c '^1 [MADRC]')
    changed=$(echo "$git_state" | grep -c '^1 .[MTD]')
    untracked=$(echo "$git_state" | grep -c '^?')

    local info="%F{cyan}($branch"

    [[ $staged -gt 0 ]] && info+=" %F{green}●$staged"
    [[ $changed -gt 0 ]] && info+=" %F{yellow}✚$changed"
    [[ $untracked -gt 0 ]] && info+=" %F{red}…$untracked"
    [[ $ahead -gt 0 ]] && info+=" %F{blue}↑$ahead"
    [[ $behind -gt 0 ]] && info+=" %F{magenta}↓$behind"

    info+="%F{cyan})%f"
    echo "$info"
  fi
}

# Two-line prompt
PROMPT='%F{magenta}%~%f $(git_prompt_info)
%F{green}$%f '
########################################################################################################################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# History file + size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
# Share history across all shells
setopt SHARE_HISTORY
# Append to history immediately (don’t overwrite)
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY   # add timestamps
# Better history behavior
setopt HIST_IGNORE_DUPS        # ignore immediate duplicates
setopt HIST_IGNORE_ALL_DUPS    # remove older duplicate entries
setopt HIST_EXPIRE_DUPS_FIRST  # expire duplicates first
setopt HIST_REDUCE_BLANKS      # remove extra blanks
setopt HIST_VERIFY             # edit before running from history
# Don't save junk commands
setopt HIST_IGNORE_SPACE       # leading space = don’t save
# Safer multi-session handling
setopt HIST_FCNTL_LOCK

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh --cmd cd)"
# plugins 
zinit ice depth=1
zinit ice wait lucid
zinit light junegunn/fzf 
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# exports 
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export SECRET=123

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases 
alias ser="source ~/.zshrc"
alias edit="nvim ~/.zshrc"
alias cl="clear"
alias ltree="eza --tree --level=2 --ignore-glob=\".git|.venv|node_modules\""
alias cat="bat"
alias vim="nvim"
zinit snippet OMZP::eza
zinit snippet OMZP::git
zinit snippet OMZP::gh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh


#  completions setup
# --- rustup zsh completions ---
if command -v rustup >/dev/null; then
  mkdir -p ~/.zfunc
  rustup completions zsh > ~/.zfunc/_rustup
  fpath=(~/.zfunc $fpath)
fi

# style 
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*:*' fzf-preview ''
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-preview '[[ -f $realpath ]] && bat --style=numbers --color=always $realpath || eza --tree --color=always $realpath'
zstyle ':fzf-tab:complete:git-*:*' fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath'
zstyle ':fzf-tab:complete:(kill|pkill|killall):*' fzf-preview 'ps -fp $word'
zstyle ':fzf-tab:complete:ssh:*' fzf-preview 'getent hosts $word'

# fnm
FNM_PATH="/home/monki/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
  fnm completions > ~/.zfunc/_fnm
  fpath=(~/.zfunc $fpath)
fi

autoload -Uz compinit 
compinit
