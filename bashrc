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

#[[ $TMUX != "" ]] && export TERM="xterm-256color"

LANG="it_IT.UTF-8"
LANGUAGE="it_IT.UTF-8"
LC_ALL="it_IT.UTF-8"

export LANG LC_ALL LANGUAGE

export FONTCONFIG_PATH="/etc/fontas"

# Textual editor
EDITOR="vim"
VISUAL="gvim"

if command -v most > /dev/null 2>&1; then
	export PAGER="most"
fi

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
#case "$TERM" in
#xterm-color|xterm-256color|xterm-derfel|screen-256color|tmux-256color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[00m\]\[\033[01;33m\]@\[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

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
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

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
mkdir -p $TMPDIR

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
alias man='LC_ALL=C man'
alias imv='mv -i'

# ag doesn't have a config file
alias ag="ag --smart-case --color-match='1;35' --color-line-number='1;34' --pager='less -MIRFX'"

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




# Path to the bash it configuration
export BASH_IT="/home/derfel/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='derfel'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
#export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
#export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
#export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
