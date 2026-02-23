if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# # PROMPT
#
# zinit light romkatv/gitstatus
#
# gitstatus_start MY_GIT
#
# precmd() {
#   gitstatus_query
#   if [[ $VCS_STATUS_RESULT == ok-sync ]]; then
#     GIT_PROMPT="%F{cyan} $VCS_STATUS_LOCAL_BRANCH%f"
#   else
#     GIT_PROMPT=""
#   fi
# }
#
# precmd() {
# 	if [[ -z "$NEW_LINE_BEFORE_PROMPT" ]]; then
# 		NEW_LINE_BEFORE_PROMPT=1
# 	else 
# 		echo 
# 	fi
# }
#
# setopt PROMPT_SUBST
#
# PROMPT="%F{blue}%~%f %F{yellow}%f 
# %F{cyan}>=%f "

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

eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# plugins 
zinit ice depth=1
zinit ice wait lucid
zinit light junegunn/fzf 
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light MichaelAquilina/zsh-you-should-use

# exports 
export FZF_COMPLETION_TRIGGER='**'
# export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export SECRET=123

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases 
alias ser="source ~/.zshrc"
alias vim="nvim"
alias edit="vim ~/.zshrc"
alias cl="clear"
alias ltree="eza --tree --level=2 --ignore-glob=\".git|.venv|node_modules\""
alias cat="bat"
zinit snippet OMZP::eza
zinit snippet OMZP::uv
zinit snippet OMZP::git
zinit snippet OMZP::gh
zinit snippet OMZP::node
zinit snippet OMZP::npm
zinit snippet OMZP::nvm
zinit snippet OMZP::bun
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

autoload -Uz compinit 
compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/monki/.bun/_bun" ] && source "/home/monki/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
