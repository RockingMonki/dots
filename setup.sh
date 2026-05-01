#/usr/bin/sh

# Install mise and activate it for now
curl https://mise.run | sh 
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

# Install essentials for the config to work 
mise use -g starship fd ripgrep neovim zoxide usage atuin eza fzf bat glow

echo "Setup complete! GO STOW ZSH now"
