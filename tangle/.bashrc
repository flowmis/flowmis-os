### EXPORT
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export ALTERNATE_EDITOR=""                        # setting for emacsclient
export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
export NEXTCLOUD_PHP_CONFIG=/etc/webapps/nextcloud/php.ini #brauche ich für die nextcloud
###Virtualenvwrapper settings
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
# source ~/.local/bin/virtualenvwrapper.sh

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '

### PATH
if [ -d "$HOME/.bin" ] ; then
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ; then
  PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin" ] ; then
  PATH="$HOME/.config/emacs/bin:$PATH"
fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### ALIASES ###

# root privileges
alias doas="doas --"

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# vim and emacs
alias vim="nvim"

# Change Wallpaper
alias wallpaper='nitrogen --random --set-scaled /home/flowmis/flowmis-os/Backgrounds'

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

# pacman and yay
alias pu='sudo pacman -Syu'                  # update only standard pkgs
alias pua='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias pi='sudo pacman -S'
alias ps='sudo pacman -Ss'
alias pd='sudo pacman -R'
alias yu='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yua='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias pc='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

# Sleeptimer
alias sleep='python /home/flowmis/cloud/life/energie/tech/skripte-programme-configs/skripte/sleeptimer.py '

# activate/mount VM shared Folder
alias share='sudo mount -t vboxsf sharewinarch /home/flowmis/sharewinarch/'

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi
