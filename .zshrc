#!/usr/bin/env zsh

#precmd() {
#    $PROMPT_COMMAND = ${PWD}
#}

source ~/.zsh/zsh-git-prompt/zshrc.sh

if [[ -z "$TMUX"  && -z "$SSH_CONNECTION" ]]; then
    tmux has-session -t global-session > /dev/null
    if [ $? -ne 0 ]; then
	tmux new-session -d -s global-session
    fi
    CLIENTID=`shuf -n1 /usr/share/dict/words | sed 's/\W//g'`
    exec tmux new-session -d -t global-session -s $CLIENTID \; set-option destroy-unattached \; new-window \; attach-session -t $CLIENTID
fi

export CLICOLOR=xterm-color
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.rar=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35::*README=1;33:*TODO=33:*ChangeLog=33:*AUTHORS=33:*CONTRIBUTORS=33:*LICENSE=33:*PKG-INFO=33:*NEWS=33:*COPYING=33:*COPYRIGHT=33:*Makefile=95:*.o=36:*.h=33:*.c=93:*.hh=33:*.cc=93:*.hxx=93:*.tar=96:*.gz=96:*.bz2=96:*.tbz=96:*.tgz=96:*.7z=96'

export LS_OPTIONS='-Fh --color=auto'
export ANDROID_HOME="/opt/android"
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
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[5;5~' redo
bindkey '^[[6;5~' undo
bindkey '^[[3;5~' delete-word
bindkey '^H' backward-delete-word


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
    export PS1='%B%{$fg[cyan]%}%T%{$reset_color%} %B%{$fg[red]%}%n%{$reset_color%}%B%F{226}@%f%B%F{13}%m%b%f %B%F{green}%~%f%b$(git_super_status) %B%F{226}#%f%b % '
fi

# GIT

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
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

git_prompt() {
    ref=$(git symbolic-ref HEAD | cut -d'/' -f3)
    echo $ref
}
# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
export HISTFILE SAVEHIST
setopt hist_ignore_all_dups

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
alias tmcs="cd ~/Documents/projects/tell-my-city-sass"
alias tmcc="cd ~/Documents/projects/tell-my-city-cordova"
alias tmc="cd ~/Documents/projects/tell-my-city"
alias gitd="git status --porcelain"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/alexis/.sdkman"
[[ -s "/home/alexis/.sdkman/bin/sdkman-init.sh" ]] && source "/home/alexis/.sdkman/bin/sdkman-init.sh"
