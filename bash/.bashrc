#!/bin/bash

# ============================================================================
# Customization Settings
# ============================================================================
alias ls='ls -Gh'

# ============================================================================
# tmux
# ============================================================================
# sessions
csession ()  {
    tmux choose-session
}

lsessions () {
    tmux list-sessions
}

nsession () {
    tmux new -s $1
}

# panes
vsplit () {
    tmux split-window -h
}

hsplit () {
    tmux split-window
}

zoom () {
    tmux resize-pane -Z
}

up () {
    tmux select-pane -U
}

down () {
    tmux select-pane -D
}

left () {
    tmux select-pane -L 
}

right () {
    tmux select-pane -R
}

dpanes () {
    tmux display-panes
}

swpanes () {
    tmux swap-pane -s $1 -t $2
}

# misc
lcommands () {
    tmux list-commands
}

