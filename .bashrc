#!/bin/bash

# generated from https://bashrcgenerator.com/
export PS1="\[\033[38;5;82m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;214m\]\h\[$(tput sgr0)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\W\[$(tput sgr0)\]\[\033[38;5;6m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43' 

HISTSIZE= HISTFILESIZE= # Infinite history

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

alias ls='ls -hN --color=auto --group-directories-first'
alias ll='ls -la'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias rc.lua='vim ~/.dotfiles/.config/awesome/rc.lua'
