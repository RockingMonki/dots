# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
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
zinit light romkatv/powerlevel10k
zinit light junegunn/fzf 
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# exports 
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export SECRET=123
export GOPATH="$HOME/go"
export GOROOT="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

# aliases 
alias ser="source ~/.zshrc"
alias edit="nvim ~/.zshrc"
alias cl="clear"
alias lg="lazygit"
alias ltree="eza --tree --level=2 --ignore-glob=\".git|.venv|node_modules\""
alias gvm="$GOPATH/bin/g"
zinit snippet OMZP::eza
zinit snippet OMZP::uv
zinit snippet OMZP::git
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh


# Rustup completions setup
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
