# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


#case "`tty`" in
	#/dev/pts/[0-9]*) export TERM="xterm-derfel"
	#/dev/pts/[0-9]*) if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi
#esac

#if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then
#	export TERMCAP=$(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')
#fi 

[[ $TMUX != "" ]] && export TERM="tmux-256color"

LANG="it_IT.UTF-8"
LANGUAGE="it_IT.UTF-8"
LC_ALL="it_IT.UTF-8"

export LANG LC_ALL LANGUAGE

export FONTCONFIG_PATH="/etc/fontas"

# Textual editor
EDITOR="vim"
VISUAL="gvim"


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make Bash append rather than overwrite the history on disk
shopt -s histappend
history -a

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
	PATH=~/bin:"${PATH}"
fi


# Check for new mail in...
MAILPATH="/var/spool/mail/derfel:~/Mail/spam:~/Mail/abuse:~/Mail/system-msg:~/Mail/debian-bugs:~/Mail/game:~/Mail/squid:~/Mail/debian-apt-trad:newsgroup:$(echo ~/Mail/Lists/* | sed -e 's/ /:/g')"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color|xterm-256color|xterm-derfel|screen-256color|tmux-256color)
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[00m\]\[\033[01;33m\]@\[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# Opzioni per Grep.
GREP_COLOR='1;32'
#GREP_OPTIONS='--directories=skip --color=auto'
export GREP_COLOR
alias grep='grep --directories=skip --color=auto'

export TMPDIR='/tmp/derfel'

# Distcc
#export CC="ccache distcc gcc"
#export CXX="ccache distcc g++"
alias dmake='make -j `distcc -j`'
alias pmake='distcc-pump make -j`distcc -j` CC=distcc'
export DISTCC_HOSTS='--randomize localhost,cpp,lzo fingolfin,cpp,lzo'

export LESSCHARSET=utf-8
# Less Hack to enable colors.
# http://blog.0x1fff.com/2009/11/linux-tip-color-enabled-pager-less.html
export LESS="-RSM~gIsw"

eval `dircolors -b ~/.dircolors`
alias ll='ls -l'
alias l='ls -la'
alias dsk='du -sh'
alias bc='bc -q'
alias diff='colordiff'
alias make='colormake'
alias man='LC_ALL=C PAGER=less man'
alias imv='mv -i'

# ad doesn't have a config file
alias ag="ag --color-match='1;35' --color-line-number='1;34' --pager='less -r'"

alias runserver="python manage.py runserver"
alias shell="python manage.py shell"
alias migrate="python manage.py migrate"
alias migration="python manage.py schemamigration"

#http_proxy="http://192.168.1.7:3128"
#HTTP_PROXY="http://192.168.1.7:3128"
no_proxy=localhost,127.0.0.0/8,*.local
NO_PROXY=localhost,127.0.0.0/8,*.local

#export http_proxy
#export HTTP_PROXY
export NO_PROXY
export no_proxy

/usr/games/fortune

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# completion for awscli
complete -C '/usr/bin/aws_completer' aws

# Set to fix wheel scrolling
#GDK_CORE_DEVICE_EVENTS=1
#export GDK_CORE_DEVICE_EVENTS

###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###


