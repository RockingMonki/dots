if [[ ":$FPATH:" != *":/home/vivek/.zsh/completions:"* ]]; then export FPATH="/home/vivek/.zsh/completions:$FPATH"; fi
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZINIT BOOTSTAP
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)" && \
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# LOAD MISE
eval "$(~/.local/bin/mise activate zsh)"

zinit ice depth=1;
zinit light romkatv/powerlevel10k

# HISTORY
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt PROMPT_SUBST

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# A. Load Definitions
zinit light zsh-users/zsh-completions
zinit snippet OMZL::history.zsh
zinit snippet OMZ::plugins/git
zinit snippet OMZ::plugins/gh
zinit snippet OMZ::plugins/rust
zinit snippet OMZ::plugins/eza
zinit snippet OMZ::plugins/uv
zinit snippet OMZ::plugins/python
zinit snippet OMZ::plugins/pip
zinit snippet OMZ::plugins/fzf

# B. Initialize Compinit (Must happen before fzf-tab)
autoload -Uz compinit
compinit

# =============================================================================
# 5. FZF & FZF-TAB
# =============================================================================

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# A. Install FZF Binary
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# B. Install Keybindings (Ctrl+R, Ctrl+T)
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

# C. Install FZF-Tab (Replaces standard menu)
zinit light Aloxaf/fzf-tab

# --- FZF CONFIGURATION ---
# Use fd (if installed) or find for faster searching
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Previews
zstyle ':fzf-tab:complete:*:*' fzf-preview ''
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# Configs
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' menu no

# =============================================================================
# 6. FINAL PLUGINS (Must be last)
# =============================================================================
zinit light zsh-users/zsh-autosuggestions
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light MichaelAquilina/zsh-you-should-use

# =============================================================================
# 7. ALIASES
# =============================================================================
alias fp="ps aux | fzf | awk '{print \$2}' | xargs kill -9"
alias fige="nvim ~/.zshrc"
alias reload="source ~/.zshrc"
alias grep='grep --color=auto'
alias vim="nvim"
alias cl="clear"
alias cat="bat"

# Better preview with exa/eza or ls
zz() {
    local dir
    dir=$(zoxide query -l | fzf \
        --height 60% \
        --reverse \
        --preview 'eza -la --color=always {} 2>/dev/null || ls -la {}' \
        --preview-window right:60% \
        --bind 'ctrl-/:toggle-preview') && cd "$dir"
}

#######################################################################################################

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
alias gvm="$GOPATH/bin/g"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# bun completions
[ -s "/home/monki/.bun/_bun" ] && source "/home/monki/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
