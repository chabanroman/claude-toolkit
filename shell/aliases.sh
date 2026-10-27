# Sourced from ~/.zshrc / ~/.bashrc by claude-toolkit's install.sh.
export PATH="$HOME/code/claude-toolkit/bin:$PATH"

# Claude session you can also drive from the phone (Claude app → Code, or claude.ai/code).
alias crc='claude --remote-control'
# Same, named after the current folder + branch so it's easy to find on the phone.
alias crcb='claude --remote-control "$(basename "$PWD"):$(git branch --show-current 2>/dev/null)"'
