# mise setup 
eval "$(~/.local/bin/mise activate zsh)"

# Prompt 
PROMPT="%F{magenta}%~%f %F{green}~>%f "

# Aliases
alias cat="bat"
alias cl="clear"
alias edit="nvim ~/.zshrc"
alias ser="source ~/.zshrc"

# Tooling setup
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"

