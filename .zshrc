# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hotgloupi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U promptinit
promptinit
setopt prompt_subst


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^W' vi-backward-kill-word

# FreeBSD + xterm
if [ -n `echo $TERM | grep rxvt` ]
then
  bindkey "\e[3~" delete-char
  bindkey "\e[7~" beginning-of-line
  bindkey "\e[8~" end-of-line
fi

function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish
# bindkey "\e[H" beginning-of-line
# bindkey "\e[F" end-of-line
# bindkey "\e[3~" delete-char
#bindkey "\e[3~" delete-char
#bindkey "\e[7~" beginning-of-line
#bindkey "\e[8~" end-of-line

plugins=(git osx syntax-highlighting)

ZSH_THEME="arrow"
export ZSH="${HOME}/.oh-my-zsh"
source "${ZSH}/oh-my-zsh.sh"

autoload -U colors && colors

red="%{${fg[red]}%}"
green="%{${fg_bold[green]}%}"
blue="%{${FG[026]}%}"
yellow="%{${fg[yellow]}%}"
cyan="%{${fg[cyan]}%}"
gray="%{${FG[008]}%}"
lightgray="%{${FG[247]}%}"
normal="%{${fg_no_bold[white]}%}"
#PROMPT="${green}%n${normal}@${green}%m${red}:${blue}%~${normal}$ "
#RPROMPT="${red}~${normal}"
export PROMPT='$lightgray%n$gray@$blue%m:$normal%~ %(?,$green,$red%?)➤ %{$reset_color%}'

function mkcd()
{
	mkdir -p "$1" && cd "$1"
}

alias clean="find . \( -name '*~' -or -name '*.pyc' -or -name '*.core' -or -name '*.pyo' \) -print -delete"

eval `dircolors -b 2> /dev/null`
if [ "`uname`" = "FreeBSD" -o "`uname`" = "Darwin" ]
then
    alias ls="ls -G"
    alias ps="ps -axwwo pid,user,command"
    export PACKAGESITE="ftp://ftp.fr.freebsd.org/pub/FreeBSD/ports/i386/packages-8.1-release/Latest/"
else
    alias ls="ls --color"
fi
alias ll="ls -l"
alias l="ll"
alias la="ll -a"
alias emacs="emacs -nw"
alias ne="emacs -nw"
alias mdl="mplayer ~/Téléchargements/*.crdownload"
alias fip="mplayer -cache 512 -cache-min 40 http://mp3.live.tv-radio.com/fip/all/fiphautdebit.mp3"
if which xdg-open 2>&1 > /dev/null
then
	alias open="xdg-open"
fi

if [ "`uname`" = Linux ]
then
	if [ -n "`grep archlinux /etc/*-release`" ]
	then
		alias s="pacman -Ss"
		alias i="sudo pacman -S"
	fi
	if [ -n "`uname -a | grep -i ubuntu`" ]
	then
		alias s="apt-cache search"
		alias i="sudo apt-get install"
	fi
fi
if [ "`uname`" = Darwin ]
then
	if [ -n "`which port`" ]
	then
		alias s="port search"
		alias i="sudo port install"
	fi
fi

PATH=\
$HOME/sandbox/llvm/tools/clang/tools/scan-build:\
$HOME/sandbox/llvm/tools/clang/tools/scan-view:\
$HOME/sandbox/llvm-install/bin:\
$HOME/sandbox/usr/bin:\
$HOME/usr/bin:\
$HOME/local/bin:\
/usr/lib/ccache:\
/usr/lib/ccache/bin:\
/opt/local/sbin:\
/opt/local/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin:\
/usr/games:\
"$PATH":\

export PATH="$PATH"
export EDITOR=vim
export FULLNAME="Raphaël Londeix"
export EMAIL="raphael.londeix@gmail.com"
export GPGKEY=89F11980
export EDITOR=vim
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
test -f ~/.me/epitech.zsh && source ~/.me/epitech.zsh
alias z="xdg-screensaver lock"
export INPUTRC=~/.inputrc
export TERM=xterm-256color

function pyh()
{
	local mod
	mod=$1
	python3 -c "import $mod; help($mod);"
}

for python_module in configure.py
do
	export PYTHONPATH="$PYTHONPATH":"$HOME/sandbox/${python_module}/src"
done

which -s g++-mp-4.7 &> /dev/null && export CXX=g++-mp-4.7
which -s g++-4.7    &> /dev/null && export CXX=g++-4.7
which -s gcc-mp-4.7 &> /dev/null && export CC=gcc-mp-4.7
which -s gcc-4.7    &> /dev/null && export CC=gcc-4.7

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-search-backward-end    # cursor up
bindkey "\e[B" history-search-forward-end     # cursor down

#( xset b off 2> /dev/null )

PERL_MB_OPT="--install_base \"/home/raph/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/raph/perl5"; export PERL_MM_OPT;
