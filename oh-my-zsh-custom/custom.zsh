#ZSH_THEME="alexdisagrees"

# correct_all, nocorrect, no_case_glob
unsetopt correct_all

# instead of xterm set to xterm-256color
# needed for tmux to use 256 colors
TERM=xterm-256color

ZBEEP=
EDITOR=vi

[[ -s "/usr/local/share/chruby/chruby.sh" ]] && source "/usr/local/share/chruby/chruby.sh" # Load chruby into a shell session *as a function*

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# aliases
alias c=clear
alias clearhist="echo '' > $HISTFILE"

if [[ -x /usr/bin/ack-grep ]]; then
  alias ogrep=/bin/grep
  alias agrep=ack-grep
  alias grep="ack-grep -a"
fi

# source rupa/z
if [[ -e $ZSH_CUSTOM/z/z.sh ]]; then
  source $ZSH_CUSTOM/z/z.sh
fi

# Move to where the arguments belong.
function after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
bindkey "^X1" after-first-word
