#!/bin/zsh

# git submodule update --init --recursive prezto

# Source Prezto color config.
if [[ -f "../prezto/modules/spectrum/init.zsh" ]]; then
  source "../prezto/modules/spectrum/init.zsh"
fi

NAME=${NAME:-prezto}
VERSION=${VERSION:-}
TMPDIR=${TMPDIR:-/tmp}
DOTFILES=${DOTFILES:-$HOME/.config/dotfiles}
MYZDOTDIR=${MYZDOTDIR:-$DOTFILES/my-prezto}
ZDOTDIR=${ZDOTDIR:-$HOME}
echo "$FG[green]--> begin install $NAME $VERSION into $INSTALLDIR $FG[none]"

# ---- install files --------------------------------------------------
echo "$FG[yellow]--> install $NAME into $ZDOTDIR$FG[none]"
setopt EXTENDED_GLOB
# link prezto
echo "$FG[yellow]--> linking prezto$FG[none]"
ln -i -s "${DOTFILES}/prezto" "${ZDOTDIR:-$HOME}/.zprezto"

# link my overrides
echo "$FG[yellow]--> linking overrides$FG[none]"
for myrcfile in "${MYZDOTDIR}"/runcoms/^README.md(.N); do
  ln -v -i -s "$myrcfile" "${ZDOTDIR:-$HOME}/.${myrcfile:t}"
done

# link stock files
echo "$FG[yellow]--> linking stock files$FG[none]"
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [[ ! -f "${MYZDOTDIR}"/runcoms/"${rcfile:t}" ]]; then
    ln -v -i -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  fi
done
# TODO fail if something does not work (eg permissions)

# ---- change shell to zsh --------------------------------------------
if [[ -z $ZSH_NAME ]]; then
  echo "$FG[yellow]--> chsh to zsh$FG[none]"
  chsh -s /bin/zsh
fi

echo ""
echo "$FG[green]--> end install $NAME. no errors logged.$FG[none]"
