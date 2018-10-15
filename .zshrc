#!/usr/bin/env zsh

#precmd() {
#    $PROMPT_COMMAND = ${PWD}
#}

if [ "$TMUX" = "" ]; then tmux; fi
export CLICOLOR=xterm-color

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.rar=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35::*README=1;33:*TODO=33:*ChangeLog=33:*AUTHORS=33:*CONTRIBUTORS=33:*LICENSE=33:*PKG-INFO=33:*NEWS=33:*COPYING=33:*COPYRIGHT=33:*Makefile=95:*.o=36:*.h=33:*.c=93:*.hh=33:*.cc=93:*.hxx=93:*.tar=96:*.gz=96:*.bz2=96:*.tbz=96:*.tgz=96:*.7z=96'

export LS_OPTIONS='-Fh --color=auto'

export EDITOR="emacs"
export VISUAL="emacs"

#Binding

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char             # Del
bindkey '^[[2~' overwrite-mode          # Insert
bindkey '^[[5~' history-search-backward # PgUp
bindkey '^[[6~' history-search-forward  # PgDn
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey '^[[Z' reverse-menu-complete

#if available, use a better pager
if command -v most &>/dev/null;then
    export PAGER=most
fi

#Completion
autoload -U compinit
compinit

#Completion non case sensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#compinstall
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*' menu select

#completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

#compltion color
zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#command correction
#setopt correctall

autoload colors;
colors
if [ "`id -u`" -eq 0 ]; then
    export PS1="%B%{$fg[cyan]%}%T%{$reset_color%} %B%{$fg[blue]%}%n%{$reset_color%}%B%F{226}@%f%B%F{13}%m%b%f %B%F{green}%~%f%b %B%F{226}#%f%b "
else
    export PS1="%B%{$fg[cyan]%}%T%{$reset_color%} %B%{$fg[red]%}%n%{$reset_color%}%B%F{226}@%f%B%F{13}%m%b%f %B%F{green}%~%f%b %B%F{226}#%f%b "
fi

# GIT
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function parse_git_status {
    noupdated=$(
        git status --porcelain 2> /dev/null |
        grep -E "^ (M|D)" |
        wc -l
    )
    nocommitted=$(
        git status --porcelain 2> /dev/null |
        grep -E "^(M|A|D|R|C)" |
        wc -l
    )

    if test $noupdated -gt 0 ; then echo -n "*"; fi
    if test $nocommitted -gt 0 ; then echo -n "+"; fi
}


if [ -f $HOME/.dircolorsrc ]; then
    eval `dircolors $HOME/.dircolorsrc`
fi

[[ -t 1 ]] && {
  chpwd() {
    case $TERM in
      sun-cmd) print -Pn "\e]l%n@%m %~\e\\" ;;
      *xterm*|rxvt|(k|E|dt)term) print -Pn "\e]0;%n@%m %~\a" ;;
    esac
  }
  chpwd
}


# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
export HISTFILE SAVEHIST

# ALIAS
alias ls="ls $LS_OPTIONS"
alias ll='ls -l'
alias l='ls -l'
alias la='ls -la'
alias tree='tree -C'
alias rmf='rm -rf'
alias -g emacs='emacs -nw'
alias reload="source ~/.zshrc"
alias xclip="xclip -selection clipboard -i"
