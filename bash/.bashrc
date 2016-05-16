#!/bin/bash

# ============================================================================
# Environment Settings
# ============================================================================
alias ls="ls -Gh"
alias la="ls -laG"

# ============================================================================
# Bookmark Functions
# ============================================================================
# Add Bookmark
wzadd () {
    full_path=$PWD
    echo $1 ${full_path/$HOME/\~} >> ~/.NERDTreeBookmarks
}

# List Bookmarks
wzprint () {
    cat ~/.NERDTreeBookmarks
}

# Go to Bookmark
wz () {
    pwd
    wz_destination=$(grep "$1 ~" ~/.NERDTreeBookmarks)
    final_destination=${wz_destination/$1 \~/\~}
    echo $final_destination
    cd $final_destination
    pwd
}

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

