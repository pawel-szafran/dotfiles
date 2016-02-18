#
# Executes commands at the start of an interactive session
#

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Options
setopt NO_SHARE_HISTORY

# Aliases
for file in $DFDIR/**/alias.zsh(N)
do
  source "$file"
done
