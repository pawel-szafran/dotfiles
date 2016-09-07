#
# Defines environment variables.
#

export DFDIR=~/.dotfiles

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Env
for file in $DFDIR/**/env.zsh(N)
do
  source "$file"
done
